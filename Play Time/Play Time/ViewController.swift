//
//  ViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/04.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import Firebase
import PTFramework
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {

    //Components
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
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
    }
    deinit {
        //Stop Listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification,
                                                  object: nil)
    }
    // MARK: Button Clicked Functions
    @IBAction func btnSignIn(_ sender: UIButton) {
        sender.pulsate()
        hideKeyboard()
        //variables
        let email = txtEmail.text
        let password = txtPassword.text
        //validation
        if password != "" && PTBasic.ptValidationCheck(email: email!) {
            signUserIn(email: email!, password: password!)
        } else {
            clearFields()
            let alertController = UIAlertController(title: "Sign In Unsuccessful", message: "Error Signing In.",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    // MARK: Functions
    @IBAction func btnSignUp(_ sender: UIButton) {
        sender.pulsate()
        self.performSegue(withIdentifier: "SignView", sender: self)
    }
    //Clearing component
    func clearFields() {
        txtEmail.text = ""
        txtPassword.text = ""
    }
    //Hiding the keyboard
    func hideKeyboard() {
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
    }
    //UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    override func willTransition(to newCollection: UITraitCollection,
                                 with coordinator: UIViewControllerTransitionCoordinator) {
        print(UIDevice.current.orientation.isLandscape)
    }
    func signUserIn(email: String, password: String) {
        // swiftlint:disable all
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            // swiftlint:enable all
            if let error = error {
                print("Failed to sign user in with error: ", error.localizedDescription)
                self.clearFields()
                self.displayError()
                return
            }
            print("Successfully Logged user in.")
            self.performSegue(withIdentifier: "HomeView", sender: self)
        }
    }
    func displayError() {
        let alertController = UIAlertController(title: "Sign In Unsuccessful", message: "Error Signing In.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
