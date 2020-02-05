//
//  ViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/04.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        sender.pulsate()
        self.performSegue(withIdentifier: "SignInView", sender: self)
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        sender.pulsate()
        self.performSegue(withIdentifier: "SignView",sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("View has loaded")
        customButtons()
        customTextBox()
    }
    
    func customTextBox() {
        txtEmail.layer.masksToBounds = true
        txtPassword.layer.masksToBounds = true
        txtEmail.layer.cornerRadius = 15.0
        txtEmail.layer.borderWidth = 1.0
        txtEmail.layer.borderColor = UIColor.black.cgColor
        txtPassword.layer.cornerRadius = 15.0
        txtPassword.layer.borderWidth = 1.0
        txtPassword.layer.borderColor = UIColor.black.cgColor
    }

    func customButtons(){
        signIn.layer.shadowColor = UIColor.black.cgColor
        signIn.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        signIn.layer.shadowRadius = 8
        signIn.layer.shadowOpacity = 0.5
        signIn.clipsToBounds = true
        signIn.layer.masksToBounds = false
        signIn.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        signIn.layer.cornerRadius = 10
        signIn.layer.borderWidth = 3.0
        signIn.layer.borderColor = UIColor.darkGray.cgColor
        
        signUp.layer.shadowColor = UIColor.black.cgColor
        signUp.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        signUp.layer.shadowRadius = 8
        signUp.layer.shadowOpacity = 0.5
        signUp.clipsToBounds = true
        signUp.layer.masksToBounds = false
        signUp.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        signUp.layer.cornerRadius = 10
        signUp.layer.borderWidth = 3.0
        signUp.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    
}

