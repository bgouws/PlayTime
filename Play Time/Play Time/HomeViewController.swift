//
//  HomeViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/17.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var btnMove: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnSignOut.customButton()
        authenticateUserAndConfigure()
    }
    // MARK: Button Action Functions
    @IBAction func btnSignOut(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: {(_) in self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    // MARK: Functions
    func authenticateUserAndConfigure() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "displayLoginView", sender: self)
            }
        }
    }
    @IBAction func btnMove(_ sender: Any) {
        self.performSegue(withIdentifier: "TimerTestView", sender: self)
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "displayLoginView", sender: self)
        } catch let error {
            print("Failed to sign out with error: ", error.localizedDescription)
        }
    }
}
