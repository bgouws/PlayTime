//
//  UIButtonExtension.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/05.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.1
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    func customButton() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5
        clipsToBounds = true
        layer.masksToBounds = false
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        layer.cornerRadius = 10
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.darkGray.cgColor
    }
    func colorChange(checker: Bool) {
        let greenColor = UIColor(red: 0.37, green: 0.58, blue: 0.33, alpha: 1.0)
        let yellowColor = UIColor(red: 0.95, green: 0.84, blue: 0.38, alpha: 1.0)
        var mainColor = UIColor(red: 0.5, green: 100/255, blue: 1, alpha: 0.5)
        if checker == true {
            mainColor = greenColor
        } else {
            mainColor = yellowColor
        }
        if backgroundColor == UIColor.lightGray {
            backgroundColor = mainColor
        } else {
            backgroundColor = UIColor.lightGray
        }
    }
}
