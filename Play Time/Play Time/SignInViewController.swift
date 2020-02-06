//
//  SignInViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/05.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var lblTest: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        
        //Creating Account Object
        var myAccounts = Accounts()
        lblTest.text = myAccounts.getEmail()
    }
}
