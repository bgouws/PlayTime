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
    func testUserLoginWithWrongCredentials() {
        application.launch()
        application.textFields["Email"].tap()
        application.tapKeys(text: "brandongouws")
        application.secureTextFields["Password"].tap()
        application.tapKeys(text: "fakepassword")
        application.buttons["Sign In"].tap()
        sleep(2)
        XCTAssert(application.staticTexts["Error"].exists)
    }
    func testUserSignsUpWithCorrectCredentials() {
        application.launch()
        let moreKey = application.keys["more"]
        sleep(2)
        application.buttons["Sign Up"].tap()
        application.textFields["Email"].tap()
        application.tapKeys(text: "testuser")
        moreKey.tap()
        application.keys["@"].tap()
        moreKey.tap()
        application.tapKeys(text: "gmail")
        moreKey.tap()
        application.keys["."].tap()
        moreKey.tap()
        application.tapKeys(text: "com")
        application.secureTextFields["Password"].tap()
        application.tapKeys(text: "supersecurepassword")
        application.secureTextFields["Confirm Password"].tap()
        application.tapKeys(text: "supersecurepassword")
        application.buttons["Create Account"].tap()
        sleep(2)
        XCTAssert(application.staticTexts["Rock"].exists)
        application.buttons["Start Working"].tap()
        application.buttons["Logout"].tap()
        let elementsQuery = application.sheets.scrollViews.otherElements
        elementsQuery.buttons["Sign Out"].tap()
    }
    func testUserLoginWithCorrectCredentials() {
        application.launch()
        let moreKey = application.keys["more"]
        application.textFields["Email"].tap()
        sleep(2)
        application.keys["b"].tap()
        application.keys["r"].tap()
        application.keys["a"].tap()
        application.keys["n"].tap()
        application.keys["d"].tap()
        application.keys["o"].tap()
        application.keys["n"].tap()
        application.keys["g"].tap()
        application.keys["o"].tap()
        application.keys["u"].tap()
        application.keys["w"].tap()
        application.keys["s"].tap()
        sleep(2)
        moreKey.tap()
        application.keys["1"].tap()
        application.keys["0"].tap()
        application.keys["0"].tap()
        application.keys["@"].tap()
        application.keys["more"].tap()
        application.tapKeys(text: "gmail")
        moreKey.tap()
        application.keys["."].tap()
        moreKey.tap()
        application.tapKeys(text: "com")
        application.secureTextFields["Password"].tap()
        application.tapKeys(text: "happydays")
        application.buttons["Sign In"].tap()
        sleep(2)
        XCTAssert(application.staticTexts["Logout"].exists)
        application.buttons["Logout"].tap()
        let elementsQuery = application.sheets.scrollViews.otherElements
        elementsQuery.buttons["Sign Out"].tap()
    }
    func testUserSignsUpWithWrongCredentials() {
        application.launch()
        application.buttons["Sign Up"].tap()
        application.textFields["Email"].tap()
        application.tapKeys(text: "brandongouws")
        application.secureTextFields["Password"].tap()
        application.tapKeys(text: "happydays")
        application.secureTextFields["Confirm Password"].tap()
        application.tapKeys(text: "saddays")
        application.buttons["Create Account"].tap()
        sleep(2)
        XCTAssert(application.staticTexts["Error"].exists)
    }
    func testUserCanNavigateToAndFromSignUpScreen() {
        application.launch()
        application.buttons["Sign Up"].tap()
        XCTAssert(application.staticTexts["Back"].exists)
        application.buttons["Back"].tap()
        XCTAssert(application.staticTexts["Sign In"].exists)
    }
    func testUserCanNavigateToSignUp() {
        application.launch()
        application.buttons["Sign Up"].tap()
        XCTAssert(application.staticTexts["Back"].exists)
    }
}
