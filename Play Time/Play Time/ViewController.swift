//
//  ViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/04.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Components
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Writing to console
        print("View has loaded")
        //Styling Components
        txtEmail.customTextBox()
        txtPassword.customTextBox()
        signUp.customButton()
        signIn.customButton()
        
        /*var email = ""
        var password = ""
        
        email = txtEmail.text!
        password = txtPassword.text!
        
        //Struct
        var myUsers = Users()
        
        myUsers.email = email
        myUsers.password = password*/
    }
    
    //Button Clicked Functions
    @IBAction func btnSignIn(_ sender: UIButton) {
        sender.pulsate()
        
        var myAccounts = Accounts()
        print("Setting email and password")
        myAccounts.setAccounts(email: "Brandon", password: "Brandon")
                
        self.performSegue(withIdentifier: "SignInView", sender: self)
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        sender.pulsate()
        self.performSegue(withIdentifier: "SignView",sender: self)
    }
}

