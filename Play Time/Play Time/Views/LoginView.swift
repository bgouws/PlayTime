//
//  loginView.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/03/24.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import PTFramework

class LoginView: UIViewController, UITextFieldDelegate {
    //Components
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting up styling
        btnLogin.defaultButton()
        txtPassword.delegate = self
        txtEmail.delegate = self
        txtEmail.customTextBox()
        txtPassword.customTextBox()
        self.hideKeyboard()
    }
    // MARK: Button Actions 
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        sender.pulsate()
        //variables
        let email = txtEmail.text
        let password = txtPassword.text
        //Sending Data to SignInVM
        let myPTAccountManagement = PTAccountManagement()
        myPTAccountManagement.ptSignIn(email: email!, password: password!) { (success, data)  in
            if success {
                print(data)
            } else {
                self.showFailureAlert()
            }
        }
    }
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        sender.pulsate()
    }
    // MARK: Helper Functions
    private func showFailureAlert() {
        reset()
        let alertController = UIAlertController(title: "Error", message:
            "An error has occured", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    private func reset() {
        txtEmail.text = ""
        txtPassword.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
