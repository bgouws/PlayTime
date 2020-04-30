//
//  CurrentTaskViewUITests.swift
//  PlayTimeUITests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest

class CurrentTaskViewUITests: XCTestCase {
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
    func testUserCanNavigateToCurrentTaskView() {
        login()
        application.staticTexts["Sample"].tap()
        sleep(8)
        snapshot("CurrentTaskScreen")
        XCTAssert(application.staticTexts["Timer View"].exists)
        application.buttons["Task List"].tap()
        logout()
    }
    func testUserCanInteractWithTimer() {
        login()
        application.staticTexts["Sample"].tap()
        sleep(8)
        XCTAssert(application.staticTexts["Timer View"].exists)
        application.buttons["Start"].tap()
        sleep(2)
        application.buttons["Next"].tap()
        sleep(2)
        application.buttons["Stop"].tap()
        sleep(2)
        application.buttons["Reset"].tap()
        application.buttons["Task List"].tap()
        logout()
    }
    func testUserCanCompleteTask() {
        login()
        application.staticTexts["Sample"].tap()
        sleep(8)
        XCTAssert(application.staticTexts["Timer View"].exists)
        application.buttons["Start"].tap()
        sleep(100)
        application.buttons["Task List"].tap()
        logout()
    }
    func testUserCanAddAndRemoveFavourite() {
        login()
        application.staticTexts["Sample"].tap()
        sleep(8)
        XCTAssert(application.staticTexts["Timer View"].exists)
        application.buttons["Start"].tap()
        sleep(2)
        application.buttons["Like"].tap()
        sleep(2)
        application.alerts["Added to favourites"].scrollViews.otherElements.buttons["Done"].tap()
        application.buttons["Like"].tap()
        sleep(2)
        application.alerts["Error"].scrollViews.otherElements.buttons["Done"].tap()
        application.buttons["Task List"].tap()
        application.buttons["Favourites"].tap()
        sleep(6)
        application.buttons["Clear Favourites"].tap()
        application.buttons["Task List"].tap()
        logout()
    }
}
