//
//  UIViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/03/24.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
