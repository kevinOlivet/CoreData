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
  
  lazy var fetchResultsController: NSFetchedResultsController<Person> = {
    let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
    let sort = NSSortDescriptor(key: #keyPath(Person.name), ascending: true)
    fetchRequest.sortDescriptors = [sort]
    let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
    fetchResultsController.delegate = self
    return fetchResultsController
  }()
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    do {
      try fetchResultsController.performFetch()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchResultsController.fetchedObjects?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let person = fetchResultsController.object(at: indexPath)
    cell.textLabel?.text = person.name
    cell.detailTextLabel?.text = person.address
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let personToDelete = fetchResultsController.object(at: indexPath)
      CoreDataManager.context.delete(personToDelete)
      CoreDataManager.saveContext()
    }
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "edit" {
      let destination = segue.destination as! UpdateViewController
      if let indexPath = tableView.indexPathForSelectedRow {
        destination.person = fetchResultsController.object(at: indexPath)
      }
    }
  }
  
  // MARK: Fetched Results Controller Delegate Methods
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      if let newIndexPath = newIndexPath {
        tableView.insertRows(at: [newIndexPath], with: .fade)
      }
    case .delete:
      if let indexPath = indexPath {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
    case .update:
      if let indexPath = indexPath {
        let cell = tableView.cellForRow(at: indexPath)
        let person = fetchResultsController.object(at: indexPath)
        cell?.textLabel?.text = person.name
        cell?.detailTextLabel?.text = person.address
      }
    case .move:
      //      if let indexPath = indexPath {
      //        tableView.deleteRows(at: [indexPath], with: .fade)
      //      }
      //      if let newIndexPath = newIndexPath {
      //        tableView.insertRows(at: [newIndexPath], with: .fade)
      //      }
      print("Entries are sorted so moving isn't supported")
    }
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
}
