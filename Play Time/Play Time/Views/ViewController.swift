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
    deinit {
        //Stop Listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification,
                                                  object: nil)
    }
    // MARK: Button Clicked Functions
    @IBAction func btnAPI(_ sender: Any) {
    }
    @IBAction func btnSignIn(_ sender: UIButton) {
        sender.pulsate()
        hideKeyboard()
        //variables
        let email = txtEmail.text
        let password = txtPassword.text
        //Sending Data to SignInVM
        if PTAccountManagement.ptSignUserIn(email: email!, password: password!) {
            self.performSegue(withIdentifier: "HomeView", sender: self)
        } else {
            clearFields()
           // displayError()
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
    func displayError() {
        let alertController = UIAlertController(title: "Sign In Unsuccessful", message: "Error Signing In.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}
