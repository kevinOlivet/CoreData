//
//  TableViewController.swift
//  CoreDataSimpleSections
//
//  Created by Jon Olivet on 10/3/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
  
  var people = [Person]()
  
  // MARK: - Lifecycle
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    loadCoreData()
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    
    return people.count
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let frame = CGRect(x: tableView.frame.width - 50, y: 0, width: 25, height: 25)
    let plusView = UIImageView(image: #imageLiteral(resourceName: "plus"))
    plusView.frame = frame
    
    let tappableHeaderView = UITableViewHeaderFooterView()
    tappableHeaderView.textLabel?.text = people[section].name
    tappableHeaderView.addSubview(plusView)
    let tapRecognizer = MyTapGestureRecognizer(target: self, action: #selector(handleTap))
    tapRecognizer.section = section
    tappableHeaderView.addGestureRecognizer(tapRecognizer)
    return tappableHeaderView
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (people[section].addresses?.count)!
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    let person = people[indexPath.section]
    cell.textLabel?.text = person.name
    let sortedAddresses = (person.addresses?.allObjects as! [Address]).sorted(by: { $0.address! < $1.address! })
    cell.detailTextLabel?.text = sortedAddresses[indexPath.row].address
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let person = people[indexPath.section]
      let allAddresses = (person.addresses?.allObjects as! [Address]).sorted(by: { $0.address! < $1.address! })
      let addressToDelete = allAddresses[indexPath.row]
      CoreDataManager.context.delete(addressToDelete)
      CoreDataManager.saveContext()
      if person.addresses?.count == 0 {
        CoreDataManager.context.delete(person)
        CoreDataManager.saveContext()
      }
      loadCoreData()
    }
  }
  
  @objc func handleTap(sender: MyTapGestureRecognizer) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "addAddress") as! AddAddressViewController
    controller.person = people[sender.section]
    show(controller, sender: self)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "update" {
      let destination = segue.destination as! UpdateViewController
      let indexPath = tableView.indexPathForSelectedRow
      destination.person = people[(indexPath?.section)!]
      destination.indexNumber = indexPath?.row
    }
  }
  
  // MARK: - Actions
  func loadCoreData() {
    let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
    let sort = NSSortDescriptor(key: "name", ascending: true)
    fetchRequest.sortDescriptors = [sort]
    do {
      let people = try CoreDataManager.context.fetch(fetchRequest)
      self.people = people
      tableView.reloadData()
    } catch  {
      print(error.localizedDescription)
    }
  }
  
}

// MARK: Helper class
class MyTapGestureRecognizer: UITapGestureRecognizer {
  var section: Int!
}
