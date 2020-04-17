//
//  loginView.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/03/24.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import PTFramework
import Firebase

class LoginView: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    //Components
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let myLoginAnalytics = LoginAnalytics()
    var allQuotes = [Quote]()
    var qCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        //Checking to see if user is logged in
        authenticateUserAndConfigure()
        //Setting up styling
        btnLogin.defaultButton()
        txtPassword.delegate = self
        txtEmail.delegate = self
        txtEmail.customTextBox()
        txtPassword.customTextBox()
        activityIndicator.isHidden = true
        self.hideKeyboard()
        //Slides
        let myPTAPIViewModel = PTAPIViewModel()
        myPTAPIViewModel.getAllQuotes { (listOfQuotes) in
            self.allQuotes = listOfQuotes
            DispatchQueue.main.async {
                self.loadQuotes(count: listOfQuotes.count, list: listOfQuotes)
            }
        }
    }
    func loadQuotes(count: Int, list: [Quote]) {
        let allSlides = createSlides(count: count, quotes: list)
        setUpSlideScrollView(slides: allSlides)
        pageControl.numberOfPages = allSlides.count
        pageControl.currentPage = 0
    }
    func authenticateUserAndConfigure() {
        let uid = Auth.auth().currentUser?.uid
        if uid != nil {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "ToHomeScreen", sender: self)
            }
        }
    }
    func createSlides(count: Int, quotes: [Quote]) -> [Slide] {
        var allSlides = [Slide]()
        for quotesCount in 0...count-1 {
            // swiftlint:disable all
            let slide:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            // swiftlint:enable all
            slide.lblQuote.text = quotes[quotesCount].quote
            allSlides.append(slide)
        }
        return allSlides
    }
    func setUpSlideScrollView(slides: [Slide]) {
        scrollView.frame = CGRect(x: 57, y: 102, width: 300, height: 200)
        scrollView.contentSize = CGSize(width: 300 * CGFloat(slides.count), height: 200)
        for noSlide in 0 ... slides.count-1 {
            slides[noSlide].frame = CGRect(x: 300 * CGFloat(noSlide), y: 0, width: 300, height: 200)
            scrollView.addSubview(slides[noSlide])
        }
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/300)
        pageControl.currentPage = Int(pageIndex)
    }
    // MARK: Button Actions
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        sender.pulsate()
        //variables
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        let email = txtEmail.text
        let password = txtPassword.text
        let accManagement = AccountManagementViewModel()
        accManagement.accountManagementView = self
        accManagement.accountManagementRepo = AccountManagementModel()
        accManagement.login(email: email!, password: password!)
    }
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        sender.pulsate()
        self.performSegue(withIdentifier: "ToSignUpView", sender: self)
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
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension LoginView: AccountManagementViewType {
    func readyForNavigation() {
        print("Ready to navigate")
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    func navigate() {
        self.performSegue(withIdentifier: "ToHomeScreen", sender: self)
    }
    func displayError(error: String) {
        showFailureAlert(error: error)
    }
}
