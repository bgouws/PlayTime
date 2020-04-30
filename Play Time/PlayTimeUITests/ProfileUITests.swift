//
//  ProfileUITests.swift
//  PlayTimeUITests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest

class ProfileUITests: XCTestCase {
    var application: XCUIApplication!
    func login() {
        application.textFields["Email"].tap()
        application.textFields["Email"].typeText("uitests@gmail.com")
        application.secureTextFields["Password"].tap()
        application.secureTextFields["Password"].typeText("happydays")
        application.buttons["Login"].tap()
        sleep(10)
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
    func testUserCanNavigateToProfileAndUpdate() {
        login()
        application.buttons["Profile"].tap()
        snapshot("ProfileScreen")
        sleep(4)
        application.buttons["Update"].tap()
        sleep(8)
        application.buttons["Task List"].tap()
        logout()
    }
}
