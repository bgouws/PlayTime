//
//  SignUpTests.swift
//  PlayTimeUITests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest

class SignUpTests: XCTestCase {
    var application: XCUIApplication!
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
    func testUserCanSignUpUnsuccessful() {
        application.buttons["Sign Up"].tap()
        application.buttons["Sign Up"].tap()
        XCTAssert(application.staticTexts["Error"].exists)
    }
    func testUserCanSignUpAndCreateAccount() {
        application.buttons["Sign Up"].tap()
        application.textFields["Email"].tap()
        application.textFields["Email"].typeText("testaccount@gmail.com")
        application.secureTextFields["Password"].tap()
        application.secureTextFields["Password"].typeText("happydays")
        application.secureTextFields["Confirm Password"].tap()
        application.secureTextFields["Confirm Password"].typeText("happydays")
        application.buttons["Sign Up"].tap()
        sleep(10)
        snapshot("MusicTasteSelectionScreen")
        application.buttons["Start Working"].tap()
        application.alerts["Error"].scrollViews.otherElements.buttons["Dismiss"].tap()
        sleep(2)
        application.buttons["RockIcon"].tap()
        application.buttons["PopIcon"].tap()
        application.buttons["IndieIcon"].tap()
        application.buttons["HipHopIcon"].tap()
        application.buttons["CountryIcon"].tap()
        application.buttons["JazzIcon"].tap()
        application.buttons["PopRockIcon"].tap()
        application.buttons["DiscoIcon"].tap()
        application.buttons["ClassicIcon"].tap()
        application.buttons["PunkIcon"].tap()
        application.buttons["Alternative"].tap()
        application.buttons["BluesIcon"].tap()
        application.buttons["HouseIcon"].tap()
        application.buttons["GrungeIcon"].tap()
        application.buttons["Techno"].tap()
        application.buttons["Techno"].tap()
        application.buttons["Start Working"].tap()
        sleep(5)
        XCTAssert(application.staticTexts["Task List"].exists)
        logout()
    }
}
