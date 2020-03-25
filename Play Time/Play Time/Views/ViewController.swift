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
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Styling Components
        txtEmail.customTextBox()
        txtPassword.customTextBox()
        signUp.nextTrack()
        signIn.customButton()
        txtEmail.customTextBox()
        txtPassword.customTextBox()
        txtPassword.delegate = self
        txtEmail.delegate = self
    }
    @IBAction func btnSignIn(_ sender: UIButton) {
        sender.pulsate()
        //variables
        let email = txtEmail.text
        let password = txtPassword.text
        //Sending Data to SignInVM
        let myPTAccountManagement = PTAccountManagement()
        myPTAccountManagement.ptSignIn(email: email!, password: password!) { (success, data)  in
            if success {
                self.performSegue(withIdentifier: "HomeView", sender: self)
                print(data)
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
    private func showFailureAlert() {
        let alertController = UIAlertController(title: "Error", message:
            "An error has occured", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
}
