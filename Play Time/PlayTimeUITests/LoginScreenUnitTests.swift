//
//  LoginScreenUnitTests.swift
//  PlayTimeUITests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest

class LoginScreenUnitTests: XCTestCase {
    var application: XCUIApplication!
    func login() {
        application.textFields["Email"].tap()
        application.textFields["Email"].typeText("uitests@gmail.com")
        application.secureTextFields["Password"].tap()
        application.secureTextFields["Password"].typeText("happydays")
        application.buttons["Login"].tap()
        sleep(5)
    }
    func logout() {
        sleep(2)
        application.buttons["Profile"].tap()
        application.navigationBars["Profile"].buttons["Settings"].tap()
        application.buttons["Sign Out"].tap()
        application.alerts["Sign out?"].scrollViews.otherElements.buttons["Yes"].tap()
    }
    override func setUp() {
        continueAfterFailure = false
        application = XCUIApplication()
        setupSnapshot(application)
        application.launch()
    }
    func testUserCanNavigateToSignUp() {
        snapshot("LoginScreen")
        application.buttons["Sign Up"].tap()
        XCTAssert(application.staticTexts["Sign Up"].exists)
        snapshot("SignUpScreen")
        application.buttons["Login"].tap()
        XCTAssert(application.staticTexts["Login"].exists)
    }
    func testUserCanLoginSuccessfully() {
        login()
        XCTAssert(application.staticTexts["Task List"].exists)
        logout()
    }
    func testUserCanLogoutSuccessfully() {
        login()
        logout()
    }
    func testUserUnsuccessfulLogin() {
        application.buttons["Login"].tap()
        XCTAssert(application.staticTexts["Error"].exists)
    }
}
