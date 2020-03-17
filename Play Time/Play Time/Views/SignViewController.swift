//
//  SignViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/05.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import PTFramework

class SignViewController: UIViewController, UITextFieldDelegate {

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
        //let ref = Data
        //Styling The Components
        btnCreateAccount.customButton()
        btnBack.customButton()
        txtPassword.customTextBox()
        txtEmail.customTextBox()
        txtComfirmPassword.customTextBox()
        txtPassword.delegate = self
        txtEmail.delegate = self
        txtComfirmPassword.delegate = self
    }
    // MARK: - Button Clicked Functions
    @IBAction func btnBack(_ sender: UIButton) {
        self.performSegue(withIdentifier: "launchView", sender: self)
    }
    @IBAction func btnCreate(_ sender: Any) {
        //Collecting data from the view
        let email = txtEmail.text
        let password = txtPassword.text
        let conPassword = txtComfirmPassword.text
        //Sending data to the VM to be validated
        let myPTAccountManagement = PTAccountManagement()
        myPTAccountManagement.ptSignUp(email: email!, password: password!,
                                       conPassword: conPassword!) { (success, data)  in
        if success {
            self.performSegue(withIdentifier: "styleView", sender: self)
        } else {
            self.showFailureAlert()
            }
        }
    }
    // MARK: - Functions
    private func showFailureAlert() {
        let alertController = UIAlertController(title: "Error", message:
            "An error has occured", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
}
