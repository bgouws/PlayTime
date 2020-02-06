//
//  SignViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/05.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {

    //Components
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtComfirmPassword: UITextField!
    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    //Function that Loads they view
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Styling The Components
        btnCreateAccount.customButton()
        btnBack.customButton()
        txtPassword.customTextBox()
        txtEmail.customTextBox()
        txtComfirmPassword.customTextBox()
    }
    
    //Button Clicked Functions
    @IBAction func btnBack(_ sender: UIButton) {
        self.performSegue(withIdentifier: "launchView", sender: self)
    }
}
