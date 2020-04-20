//
//  ProfileUITest.swift
//  PlayTimeUITests
//
//  Created by Brandon Gouws on 2020/03/30.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest

class ProfileUITest: XCTestCase {
    var application: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false
        application = XCUIApplication()
        setupSnapshot(application)
        XCUIApplication().launch()
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
    func testUserNavigatesToProfile() {
        login()
        sleep(1)
        application.buttons["Profile"].tap()
        sleep(1)
        snapshot("ProfileScreen")
        application.buttons["Task List"].tap()
        sleep(1)
        logout()
    }
}
