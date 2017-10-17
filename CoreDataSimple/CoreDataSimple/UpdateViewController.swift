//
//  EditViewController.swift
//  CoreDataSimple
//
//  Created by Jon Olivet on 10/3/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit
import CoreData

class UpdateViewController: UIViewController {
  
  var person: Person!
  
  @IBOutlet weak var nameTextfield: UITextField!
  @IBOutlet weak var addressTextfield: UITextField!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }
  
  // MARK: - Actions
  @IBAction func updateTapped(_ sender: UIButton) {
    updateData()
  }
  
  func setUp() {
    guard let name = person.name else { return }
    navigationItem.title = "Update \(name)"
    nameTextfield.text = name
    addressTextfield.text = person.address
    nameTextfield.placeholder = "Update name"
    addressTextfield.placeholder = "Update address"
  }
  
  func updateData() {
    if nameTextfield.text != "" && addressTextfield.text != "" {
      person.name = nameTextfield.text
      person.address = addressTextfield.text
      CoreDataManager.saveContext()
      navigationController?.popViewController(animated: true)
    } else {
      showAlert()
    }
  }
  
}
