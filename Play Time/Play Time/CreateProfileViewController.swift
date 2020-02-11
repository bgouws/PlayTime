//
//  CreateProfileViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/11.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Declaration of components
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var txtBio: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Preparing View
        btnCreate.customButton()
        txtName.customTextBox()
        txtSurname.customTextBox()
        
        txtSurname.delegate = self
        txtName.delegate = self
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object:nil)
    }
    
    deinit {
        //Stop Listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object:nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object:nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object:nil)
    }
    
    //When the keyboard will change its state
    @objc func keyboardWillChange(notification: Notification) {
        print("Keyboard will show: \(notification.name.rawValue)")
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
    }
    
    //Hiding the keyboard
    func hideKeyboard() {
        txtSurname.resignFirstResponder()
        txtName.resignFirstResponder()
        
    }
    
    //UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
}
