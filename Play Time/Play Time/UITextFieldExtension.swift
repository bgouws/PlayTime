//
//  UITextFieldExtension.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/05.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func customTextBox() {
        layer.masksToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 15.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
    }
}
