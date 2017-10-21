//
//  AddAddressViewController.swift
//  CoreDataSimpleSections
//
//  Created by Jon Olivet on 10/13/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit

class AddAddressViewController: UIViewController {

  var address: Address!
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
    guard let name = address.people?.name else { return }
    navigationItem.title = "Add an Address for \(name)"
    addressTextfield.placeholder = "Add an Address for \(name)"
  }
  
  func addData() {
    if addressTextfield.text != "" {
      let newAddress = Address(context: CoreDataManager.context)
      newAddress.address = addressTextfield.text
      newAddress.people = self.address.people
      CoreDataManager.saveContext()
      navigationController?.popViewController(animated: true)
    } else {
      showAlert()
    }
  }

}
