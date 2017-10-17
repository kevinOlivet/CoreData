//
//  EditViewController.swift
//  CoreDataSimpleSections
//
//  Created by Jon Olivet on 10/3/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit
import CoreData

class UpdateViewController: UIViewController {
  
  var person: Person!
  var indexNumber: Int!
  lazy var sortedAddresses = {(person.addresses?.allObjects as! [Address]).sorted(by: { $0.address! < $1.address! })}()

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
    nameTextfield.text = person.name
    addressTextfield.text = sortedAddresses[indexNumber].address
    nameTextfield.placeholder = "Update name"
    addressTextfield.placeholder = "Update address"
  }
  
  func updateData() {
    if nameTextfield.text != "" && addressTextfield.text != "" {
      person.name = nameTextfield.text
      sortedAddresses[indexNumber].address = addressTextfield.text
      CoreDataManager.saveContext()
      navigationController?.popViewController(animated: true)
    } else {
      showAlert()
    }
  }
  
}
