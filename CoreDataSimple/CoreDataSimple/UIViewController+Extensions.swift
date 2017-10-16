//
//  UIViewController+Extensions.swift
//  CoreDataSimple
//
//  Created by Jon Olivet on 10/13/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit

extension UIViewController {
  func showAlert() {
    let alert = UIAlertController(title: "Oops", message: "Please enter a name and address!", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okAction)
    present(alert, animated: true, completion: nil)
  }
}
