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
    deinit {
        //Stop Listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    // MARK: - Button Clicked Functions
    @IBAction func btnBack(_ sender: UIButton) {
        self.performSegue(withIdentifier: "launchView", sender: self)
    }
    @IBAction func btnCreate(_ sender: Any) {
        //variables
        let email = txtEmail.text
        let password = txtPassword.text
        let conPassword = txtComfirmPassword.text
        //validation
        if email?.isValidEmail(email!) ?? false && password != "" && conPassword != "" && conPassword == password {
            creatUser(email: email!, password: password!)
        } else {
            clearFields()
            let alertController = UIAlertController(title: "Sign Up Unsuccessful",
                                                    message: "Error Signing Up.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    // MARK: - Functions
    //Clearing component
    func clearFields() {
        txtEmail.text = ""
        txtPassword.text = ""
        txtComfirmPassword.text = ""
    }
    //Hiding the keyboard
    func hideKeyboard() {
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
        txtComfirmPassword.resignFirstResponder()
    }
    //UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    func creatUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Failed to create user ", error.localizedDescription)
                return
            }
            guard let uid = result?.user.uid else { return }
            Database.database().reference().child("users").child(uid).updateChildValues(["email": email], withCompletionBlock: { error, ref in
                if let error = error {
                    print("Failed to update database values with error: ", error.localizedDescription)
                    return
            }
                print("Successful Sign Up")
                self.performSegue(withIdentifier: "styleView", sender: self)
            })
        }
    }
}
