//
//  CoreTableViewController.swift
//  CoreDataClosure
//
//  Created by Jon Olivet on 10/2/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit
import CoreData

class CoreTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var people = [Person]()
  
  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    loadCoreData()
  }
  
  // MARK: - Table view methods
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
    
    if let profileImage = UIImage(data: person.picture!) {
      cell.imageView?.image = profileImage
    }
    return cell
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      
      let personToDelete = people[indexPath.row]
      
      let confirmDeleteAlertController = UIAlertController(title: "Delete Person", message: "Are you sure you want to delete \(String(describing: personToDelete.name!))", preferredStyle: .alert)
      
      let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: { (action) in
        CoreDataManager.context.delete(personToDelete)
        CoreDataManager.saveContext()
        self.loadCoreData()

      })
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      
      confirmDeleteAlertController.addAction(deleteAction)
      confirmDeleteAlertController.addAction(cancelAction)
      
      present(confirmDeleteAlertController, animated: true, completion: nil)
    
    }
  }
  
  // MARK: - Actions
  func loadCoreData() {
    CoreDataManager.fetchCoreData { (people: [Person]?) in
      if let people = people {
        self.people = people
      }
      self.tableView.reloadData()
    }
  }
  
  @IBAction func addPersonTapped(_ sender: UIBarButtonItem) {
    let picker = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.delegate = self
    present(picker, animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      picker.dismiss(animated: true, completion: {
        self.addPerson(with: image)
      })
    }
  }
  var alert: UIAlertController!
  
  func addPerson(with image: UIImage){
    alert = UIAlertController(title: "Add Person", message: "Create a person", preferredStyle: .alert)
    alert.addTextField { (textfield) in
      textfield.placeholder = "Name"
    }
    alert.addTextField { (textfield) in
      textfield.placeholder = "Address"
    }
    let action = UIAlertAction(title: "Save", style: .default) { (_) in
      let nameTextfield = self.alert.textFields?.first
      let addressTextfield = self.alert.textFields?.last
      
      guard nameTextfield?.text != "" && addressTextfield?.text != "" else {
        print("Not enough data!"); return }
        let person = Person(context: CoreDataManager.context)
        person.picture = NSData(data: UIImageJPEGRepresentation(image, 0.3)!) as Data
        person.name = nameTextfield?.text
        person.address = addressTextfield?.text
        CoreDataManager.saveContext()
        self.loadCoreData()
    }
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }

}
