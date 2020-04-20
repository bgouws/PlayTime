//
//  PlayTimeUITests.swift
//  PlayTimeUITests
//
//  Created by Brandon Gouws on 2020/03/15.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import XCTest

class LoginScreenUITest: XCTestCase {
    var application: XCUIApplication!
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test.
        // Doing this in setup will make sure it happens for each test method.
        application = XCUIApplication()
        setupSnapshot(application)
    }
    func testUserLoginWithWrongCredentials() {
        application.launch()
        application.buttons["Login"].tap()
        sleep(2)
        XCTAssert(application.staticTexts["Error"].exists)
    }
    func testUserSignsUpWithWrongCredentials() {
        application.launch()
        application.buttons["Sign Up"].tap()
        application.buttons["Sign Up"].tap()
        sleep(2)
        XCTAssert(application.staticTexts["Error"].exists)
    }
    func testUserCanNavigateToAndFromSignUpScreen() {
        application.launch()
        snapshot("LoginScreen")
        application.buttons["Sign Up"].tap()
        snapshot("SignUpScreen")
        XCTAssert(application.staticTexts["Login"].exists)
        application.buttons["Login"].tap()
        XCTAssert(application.staticTexts["Login"].exists)
    }
    func testUserCanNavigateToSignUp() {
        application.launch()
        application.buttons["Sign Up"].tap()
        XCTAssert(application.staticTexts["Login"].exists)
    }
    func testUserCanLoginSuccessfully() {
        application.launch()
        login()
        sleep(4)
        XCTAssert(application.staticTexts["Logout"].exists)
        snapshot("TaskListScreen")
        sleep(2)
        logout()
    }
    func testUserCanSignUpSuccessfully() {
//        application.launch()
//        application.buttons["Sign Up"].tap()
//        application.textFields["Email"].tap()
//        application.textFields["Email"].typeText("testUser@gmail.com")
//        application.secureTextFields["Password"].tap()
//        application.secureTextFields["Password"].typeText("Password")
//        application.secureTextFields["Confirm Password"].tap()
//        application.secureTextFields["Confirm Password"].typeText("Password")
//        sleep(2)
//        application.buttons["Sign Up"].tap()
//        sleep(8)
//        musicSelection()
//        musicSelection()
//        application.buttons["Start Working"].tap()
//        sleep(2)
//        XCTAssert(application.staticTexts["Logout"].exists)
//        sleep(2)
//        logout()
    }
    func login() {
        application.textFields["Email"].tap()
        application.textFields["Email"].typeText("saddays@gmail.com")
        sleep(1)
        application.secureTextFields["Password"].tap()
        application.secureTextFields["Password"].typeText("happydays")
        application.buttons["Login"].tap()
        sleep(2)
    }
    func logout() {
        application.buttons["Logout"].tap()
        let elementsQuery = application.sheets.scrollViews.otherElements
        elementsQuery.buttons["Sign Out"].tap()
        snapshot("LoggedOutScreen")
        sleep(2)
    }
    func musicSelection() {
        sleep(2)
        application.buttons["Rock"].tap()
        sleep(1)
        application.buttons["Pop"].tap()
        sleep(1)
        application.buttons["Indie"].tap()
        sleep(1)
        application.buttons["Hip Hop"].tap()
        snapshot("MusicSelectionScreen")
        sleep(1)
        application.buttons["Country"].tap()
        sleep(1)
        application.buttons["Jazz"].tap()
        sleep(2)
    }
}
