//
//  UIImageViewExtension.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/03/22.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func albumArtStyle() {
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 8.0
    }
    func profileView() {
        //clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.width / 2
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.darkGray.cgColor
    }
}
