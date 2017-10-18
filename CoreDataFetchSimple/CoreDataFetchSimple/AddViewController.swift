//
//  AddViewController.swift
//  CoreDataFetchSimple
//
//  Created by Jon Olivet on 10/4/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
  
  @IBOutlet weak var nameTextfield: UITextField!
  @IBOutlet weak var addressTextfield: UITextField!
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }
  
  // MARK: - Actions
  @IBAction func saveTapped(_ sender: UIButton) {
    saveCoreData()
  }
  
  func setUp() {
    navigationItem.title = "Add New"
    nameTextfield.placeholder = "Enter Name"
    addressTextfield.placeholder = "Enter Address"
  }
  
  func saveCoreData() {
    if nameTextfield.text != ""  && addressTextfield.text != "" {
      let person = Person(context: CoreDataManager.context)
      person.name = nameTextfield.text
      person.address = addressTextfield.text
      
      CoreDataManager.saveContext()
      navigationController?.popViewController(animated: true)
    } else {
      showAlert()
    }
  }
  
}
