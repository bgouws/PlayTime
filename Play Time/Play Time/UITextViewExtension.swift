//
//  File.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/14.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    func customBio() {
        backgroundColor = UIColor.white
        clipsToBounds = true
        layer.masksToBounds = false
        layer.cornerRadius = 10
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
    }
}
