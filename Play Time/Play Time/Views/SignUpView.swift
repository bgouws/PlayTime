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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let mySignUpAnalytics = SignUpAnalytics()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting up styling
        activityIndicator.isHidden = true
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
        let accManagement = AccountManagementViewModel()
        activityIndicator.isHidden = false
        accManagement.accountManagementView = self
        accManagement.accountManagementRepo = AccountManagementModel()
        accManagement.signUp(email: email!, password: password!)
    }
    @IBAction func btnBackToLoginTapped(_ sender: UIButton) {
        sender.pulsate()
        self.performSegue(withIdentifier: "ToLoginView", sender: self)
    }
    // MARK: Helper Functions
    private func showFailureAlert(error: String) {
        reset()
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        let alertController = UIAlertController(title: "Error", message:
            "\(error)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    private func reset() {
        txtEmail.text = ""
        txtPassword.text = ""
        txtConfirmPassword.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension SignUpView: AccountManagementViewType {
    func readyForNavigation() {
        print("Ready to navigate")
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    func navigate() {
        self.performSegue(withIdentifier: "ToMusicTaste", sender: self)
    }
    func displayError(error: String) {
        showFailureAlert(error: error)
    }
}
