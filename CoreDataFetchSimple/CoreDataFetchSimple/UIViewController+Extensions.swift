//
//  UIViewController+Extensions.swift
//  CoreDataFetchSimple
//
//  Created by Jon Olivet on 10/16/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit

extension UIViewController {
  func showAlert() {
    let alert = UIAlertController(title: "Oops!", message: "Please enter a name and address!", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(okAction)
    present(alert, animated: true, completion: nil)
  }
}
