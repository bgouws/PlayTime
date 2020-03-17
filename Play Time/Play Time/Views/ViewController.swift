//
//  ViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/04.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
import PTFramework

class ViewController: UIViewController, UITextFieldDelegate {

    //Components
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var btnAPI: UIButton!
    @IBOutlet weak var imgTest: UIImageView!

    override func viewDidLoad() {
        //This is the new update
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Styling Components
        txtEmail.customTextBox()
        txtPassword.customTextBox()
        signUp.customButton()
        signIn.customButton()
        txtPassword.delegate = self
        txtEmail.delegate = self
        //Hitting Api
        //PTPlayMusic.ptPrint()
        //Calling API
    }
    @IBAction func btnSignIn(_ sender: UIButton) {
        sender.pulsate()
        hideKeyboard()
        //variables
        let email = txtEmail.text
        let password = txtPassword.text
        //Sending Data to SignInVM
        let myPTAccountManagement = PTAccountManagement()
        myPTAccountManagement.ptSignIn(email: email!, password: password!) { (success, data)  in
            if success {
                self.performSegue(withIdentifier: "HomeView", sender: self)
            } else {
                self.showFailureAlert()
            }
        }
    }
    // MARK: Functions
    @IBAction func btnSignUp(_ sender: UIButton) {
        sender.pulsate()
        self.performSegue(withIdentifier: "SignView", sender: self)
    }
    //Hiding the keyboard
    func hideKeyboard() {
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
    }
    private func showFailureAlert() {
        let alertController = UIAlertController(title: "Error", message:
            "An error has occured", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
}
