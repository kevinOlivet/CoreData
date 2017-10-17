//
//  AddAddressViewController.swift
//  CoreDataSimpleSections
//
//  Created by Jon Olivet on 10/13/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit

class AddAddressViewController: UIViewController {

  var person: Person!
  
  @IBOutlet weak var addressTextfield: UITextField!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }
  
  // MARK: - Actions
  @IBAction func addAddressTapped(_ sender: UIButton) {
    addData()
  }
  
  func setUp() {
    guard let name = person.name else { return }
    navigationItem.title = "Add an Address for \(name)"
    addressTextfield.placeholder = "Add an Address for \(name)"
  }
  
  func addData() {
    if addressTextfield.text != "" {
      let address = Address(context: CoreDataManager.context)
      address.address = addressTextfield.text
      person.addToAddresses(address)
      CoreDataManager.saveContext()
      navigationController?.popViewController(animated: true)
    } else {
      showAlert()
    }
  }

}
