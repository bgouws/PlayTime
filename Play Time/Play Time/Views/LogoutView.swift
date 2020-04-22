//
//  LogoutView.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/03/30.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class LogoutView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}
