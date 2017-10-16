//
//  TableViewController.swift
//  CoreDataSimple
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
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let person = people[indexPath.row]
    cell.textLabel?.text = person.name
    cell.detailTextLabel?.text = person.address
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let personToDelete = people[indexPath.row]
      CoreDataManager.context.delete(personToDelete)
      CoreDataManager.saveContext()
      loadCoreData()
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
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "edit" {
      let destination = segue.destination as! EditViewController
      let indexPath = tableView.indexPathForSelectedRow
      destination.person = people[(indexPath?.row)!]
    }
  }
  
}
