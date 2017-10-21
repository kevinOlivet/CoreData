//
//  UpdateViewController.swift
//  CoreDataFetchSimple
//
//  Created by Jon Olivet on 10/4/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

  var address: Address!

  @IBOutlet weak var nameTextfield: UITextField!
  @IBOutlet weak var addressTextfield: UITextField!
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }
  
  // MARK: - Actions
  @IBAction func updateTapped(_ sender: UIButton) {
    updateCoreData()
  }
  
  func setUp() {
    guard let name = address.people?.name else { return }
    navigationItem.title = "Update \(name)"
    nameTextfield.text = name
    addressTextfield.text = address.address
    nameTextfield.placeholder = "Update Name"
    addressTextfield.placeholder = "Update Address"
  }
  
  func updateCoreData() {
    if nameTextfield.text != ""  && addressTextfield.text != "" {
      address.people?.name = nameTextfield.text
      address.address = addressTextfield.text
      self.address.people = address.people
      CoreDataManager.saveContext()
      navigationController?.popViewController(animated: true)
    } else {
      showAlert()
    }
  }
  
}
