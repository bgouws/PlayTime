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
        //This is the new update
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Writing to console
        print("View has loaded")
        //Styling Components
        txtEmail.customTextBox()
        txtPassword.customTextBox()
        signUp.customButton()
        signIn.customButton()
    }
    
    //Button Clicked Functions
    @IBAction func btnSignIn(_ sender: UIButton) {
        sender.pulsate()
                
        self.performSegue(withIdentifier: "SignInView", sender: self)
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        sender.pulsate()
        self.performSegue(withIdentifier: "SignView",sender: self)
    }
}

