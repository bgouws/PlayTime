//
//  SignUpView.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/03/25.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import PTFramework

class SignUpView: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnBackToLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting up styling
        txtConfirmPassword.delegate = self
        txtPassword.delegate = self
        txtEmail.delegate = self
        txtEmail.customTextBox()
        txtPassword.customTextBox()
        txtConfirmPassword.customTextBox()
        btnSignUp.defaultButton()
        self.hideKeyboard()
    }
    // MARK: Button Actions
    @IBAction func btnSignUpTapped(_ sender: Any) {
        let email = txtEmail.text
        let password = txtPassword.text
        let conPassword = txtConfirmPassword.text
        //Sending data to the VM to be validated
        let myPTAccountManagement = PTAccountManagement()
        myPTAccountManagement.ptSignUp(email: email!, password: password!,
                                       conPassword: conPassword!) { (success, data)  in
        if success {
            print(data)
        } else {
            self.showFailureAlert()
            }
        }
    }
    @IBAction func btnBackToLoginTapped(_ sender: UIButton) {
        sender.pulsate()
        self.performSegue(withIdentifier: "ToLoginView", sender: self)
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
