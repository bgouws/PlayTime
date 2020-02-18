//
//  LaunchViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/18.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var imgLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func animateLogo() {
        UIView.animate(withDuration: 1, animations: {
            self.imgLogo.frame.origin.y -= 50
        }, completion: nil)
    }
}
