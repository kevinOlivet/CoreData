//
//  ViewController.swift
//  CoreDataSimpleSections
//
//  Created by Jon Olivet on 10/3/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
  
  @IBOutlet weak var nameTextfield: UITextField!
  @IBOutlet weak var addressTextfield: UITextField!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }
  
  // MARK: - Actions
  @IBAction func saveTapped(_ sender: UIButton) {
    addPerson()
  }
  
  func setUp(){
    navigationItem.title = "Add New"
    nameTextfield.placeholder = "Enter name"
    addressTextfield.placeholder = "Enter address"
  }
  
  func addPerson() {
    if nameTextfield.text != "" && addressTextfield.text != "" {
      let address = Address(context: CoreDataManager.context)
      address.address = addressTextfield.text

      let person = Person(context: CoreDataManager.context)
      address.people = person
      address.people?.name = nameTextfield.text

      CoreDataManager.saveContext()
      navigationController?.popViewController(animated: true)
    } else {
      showAlert()
    }
  }

}
