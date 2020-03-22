//
//  UIViewExtension.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/03/22.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func trackLayers() {
        clipsToBounds = true
        layer.masksToBounds = false
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.darkGray.cgColor
    }
    func mainView() {
        clipsToBounds = true
        layer.masksToBounds = false
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.darkGray.cgColor
    }
}
