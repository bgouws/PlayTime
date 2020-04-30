//
//  ProfileSettingsView.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/04/27.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import PTFramework

class ProfileSettingsView: UIViewController {
    @IBOutlet weak var actIn: UIActivityIndicatorView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtQuote: UITextField!
    @IBOutlet weak var btnAddQuote: UIButton!
    @IBOutlet weak var btnSignOut: UIButton!
    let quotesPostViewModel = QuotesPostViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    private func prepareView() {
        txtFirstName.customTextBox()
        txtLastName.customTextBox()
        txtQuote.customTextBox()
        btnAddQuote.defaultButton()
        btnSignOut.defaultButton()
        actIn.isHidden = true
        actIn.stopAnimating()
    }
    @IBAction func btnAddQuoteTapped(_ sender: Any) {
        guard let firstName = txtFirstName.text else { return }
        guard let lastName = txtLastName.text else { return }
        guard let quote = txtQuote.text else {return}
        quotesPostViewModel.repo = QuotesPostRepo(id: "1", firstName: firstName, lastName: lastName, quote: quote)
        quotesPostViewModel.view = self
        showLoadingIndicator()
        quotesPostViewModel.postNewQuote()
    }
    private func showAlert(title: String, desc: String) {
        let alertController = UIAlertController(title: title, message:
            desc, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    private func showLoadingIndicator() {
        actIn.startAnimating()
        actIn.isHidden = false
    }
    private func hideLoadingIndicator() {
        actIn.stopAnimating()
        actIn.isHidden = true
    }
    private func clearComponents() {
        txtFirstName.text = ""
        txtLastName.text = ""
        txtQuote.text = ""
    }
    @IBAction func btnSignOut(_ sender: Any) {
        let alert = UIAlertController(title: "Sign out?",
                                      message: "Are you sure you want to sign out?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.showLoadingIndicator()
            let accountManagementViewModel = AccountManagementViewModel()
            accountManagementViewModel.accountManagementRepo = AccountManagementModel()
            accountManagementViewModel.accountManagementView = self
            accountManagementViewModel.signOut()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
        }))
        self.present(alert, animated: true)
    }
}
extension ProfileSettingsView: QuotesPostViewType {
    func displayError(error: Error) {
        DispatchQueue.main.async {
            self.showAlert(title: "Error", desc: error.localizedDescription)
            self.hideLoadingIndicator()
            self.clearComponents()
        }
    }
    func displaySuccess(isSuccessful: Bool) {
        DispatchQueue.main.async {
            if isSuccessful {
                self.showAlert(title: "Added Quote", desc: "Successfully added quote.")
            } else {
                self.showAlert(title: "Error", desc: "Something went wrong.")
            }
            self.hideLoadingIndicator()
            self.clearComponents()
        }
    }
}
extension ProfileSettingsView: AccountManagementViewType {
    func readyForNavigation() {
        hideLoadingIndicator()
    }
    func navigate() {
        self.performSegue(withIdentifier: "ToLoggedOutScreen", sender: self)
    }
    func displayError(error: String) {
        showAlert(title: "Error", desc: error)
    }
}
