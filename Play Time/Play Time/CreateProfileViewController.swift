//
//  CreateProfileViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/11.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate,
                                   UIImagePickerControllerDelegate {

    // MARK: - Declaration of components
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var txtBio: UITextView!
    @IBOutlet weak var btnRock: UIButton!
    @IBOutlet weak var btnPop: UIButton!
    @IBOutlet weak var btnIndie: UIButton!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnJazz: UIButton!
    @IBOutlet weak var btnHipHop: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - Preparing View
        btnCreate.customButton()
        txtName.customTextBox()
        txtSurname.customTextBox()
        txtSurname.delegate = self
        btnRock.backgroundColor = UIColor.gray
        btnPop.backgroundColor = UIColor.gray
        btnIndie.backgroundColor = UIColor.gray
        btnCountry.backgroundColor = UIColor.gray
        btnJazz.backgroundColor = UIColor.gray
        btnHipHop.backgroundColor = UIColor.gray
        //Assinging Customization
        btnRock.customSelectButton()
        btnPop.customSelectButton()
        btnIndie.customSelectButton()
        btnCountry.customSelectButton()
        btnJazz.customSelectButton()
        btnHipHop.customSelectButton()
        txtBio.customBio()
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    deinit {
        //Stop Listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    // MARK: - Button Functions
    @IBAction func btnCreate(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.camera
        image.allowsEditing = true
        self.present(image, animated: true) {
            //After its complete
        }
    }
    @IBAction func btnRock(_ sender: UIButton) {
    }
    @IBAction func btnPop(_ sender: UIButton) {
    }
    @IBAction func btnIndie(_ sender: UIButton) {
    }
    @IBAction func btnCountry(_ sender: UIButton) {
    }
    @IBAction func btnJazz(_ sender: UIButton) {
    }
    @IBAction func btnHipHop(_ sender: UIButton) {
    }
    // MARK: - Functions
    //When the keyboard will change its state
    @objc func keyboardWillChange(notification: Notification) {
        print("Keyboard will show: \(notification.name.rawValue)")
        guard let keyboardRect =
            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
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
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        //if let image = info [UIImagePickerController.SourceType] as? UIImage{
        //    imgProfile.image = image
        //}
    }
}
