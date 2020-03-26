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
    }
//    func testUserLoginWithWrongCredentials() {
//        application.launch()
//        application.buttons["Sign In"].tap()
//        sleep(2)
//        XCTAssert(application.staticTexts["Error"].exists)
//    }
//    func testUserSignsUpWithWrongCredentials() {
//        application.launch()
//        application.buttons["Sign Up"].tap()
//        application.buttons["Create Account"].tap()
//        sleep(2)
//        XCTAssert(application.staticTexts["Error"].exists)
//    }
//    func testUserCanNavigateToAndFromSignUpScreen() {
//        application.launch()
//        application.buttons["Sign Up"].tap()
//        XCTAssert(application.staticTexts["Back"].exists)
//        application.buttons["Back"].tap()
//        XCTAssert(application.staticTexts["Sign In"].exists)
//    }
//    func testUserCanNavigateToSignUp() {
//        application.launch()
//        application.buttons["Sign Up"].tap()
//        XCTAssert(application.staticTexts["Back"].exists)
//    }
}
