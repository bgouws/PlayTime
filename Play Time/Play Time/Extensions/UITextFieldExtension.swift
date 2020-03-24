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
        layer.cornerRadius = 8.0
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        clipsToBounds = true
    }
}
