//
//  FetchTableViewController.swift
//  CoreDataFetchSimple
//
//  Created by Jon Olivet on 10/4/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit
import CoreData

class FetchTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  
  lazy var fetchedResultsController: NSFetchedResultsController<Address> = {
    let fetchRequest: NSFetchRequest<Address> = Address.fetchRequest()
    let sort = NSSortDescriptor(key: #keyPath(Address.people.name), ascending: true)
    let sort2 = NSSortDescriptor(key: #keyPath(Address.address), ascending: true)
    fetchRequest.sortDescriptors = [sort, sort2]
    let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: #keyPath(Address.people.name), cacheName: nil)
    fetchResultsController.delegate = self
    return fetchResultsController
  }()
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    do {
      try fetchedResultsController.performFetch()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return fetchedResultsController.sections?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let frame = CGRect(x: tableView.frame.width - 50, y: 0, width: 25, height: 25)
    let plusView = UIImageView(image: #imageLiteral(resourceName: "plus"))
    plusView.frame = frame
    
    let tappableHeaderView = UITableViewHeaderFooterView()
    tappableHeaderView.textLabel?.text = fetchedResultsController.sections![section].name
    tappableHeaderView.addSubview(plusView)
    let tapRecognizer = MyTapGestureRecognizer(target: self, action: #selector(handleTap))
    tapRecognizer.section = section
    tappableHeaderView.addGestureRecognizer(tapRecognizer)
    return tappableHeaderView
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedResultsController.sections?[section].numberOfObjects ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let address = fetchedResultsController.object(at: indexPath)
    cell.textLabel?.text = address.people?.name
    cell.detailTextLabel?.text = address.address
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let address = fetchedResultsController.object(at: indexPath)
      let person = address.people
      CoreDataManager.context.delete(address)
      CoreDataManager.saveContext()
      if person?.addresses?.count == 0 {
        CoreDataManager.context.delete(person!)
        CoreDataManager.saveContext()
      }
    }
  }
  
  // MARK: - Actions
  @objc func handleTap(sender: MyTapGestureRecognizer) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "addAddress") as! AddAddressViewController
    controller.address = fetchedResultsController.sections?[sender.section].objects?.first as! Address
    show(controller, sender: self)
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "update" {
      let destination = segue.destination as! UpdateViewController
      if let indexPath = tableView.indexPathForSelectedRow {
        destination.address = fetchedResultsController.object(at: indexPath)
      }
    }
  }
  
  // MARK: Fetched Results Controller Delegate Methods
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .delete:
      if let indexPath = indexPath {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
      print("deleted index Path")
    case .insert:
      if let newIndexPath = newIndexPath {
        tableView.insertRows(at: [newIndexPath], with: .fade)
      }
      print("inserted index Path")
    case .update:
      if let indexPath = indexPath {
        let cell = tableView.cellForRow(at: indexPath)
        let address = fetchedResultsController.object(at: indexPath)
        cell?.textLabel?.text = address.people?.name
        cell?.detailTextLabel?.text = address.address
        print("updated index Path")
        CoreDataManager.context.refreshAllObjects()
      }
    case .move:
      if let indexPath = indexPath {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
      if let newIndexPath = newIndexPath {
        tableView.insertRows(at: [newIndexPath], with: .fade)
      }
    }
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    switch type {
    case .delete:
      tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
      print("deleted section")
    case .insert:
      tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
      print("inserted section")
    case .update:
      tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
      tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
      print("updated section")
    case .move:
      tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
      tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
      print("moved section")
      
    }
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
}
