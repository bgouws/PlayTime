//
//  ToDoScreenUITest.swift
//  PlayTimeUITests
//
//  Created by Brandon Gouws on 2020/03/16.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest

class ToDoScreenUITest: XCTestCase {
    var application: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false
        application = XCUIApplication()
        setupSnapshot(application)
        application.launch()
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
    func testUserCanRemoveTask() {
        login()
        let tablesQuery = application.tables
        sleep(10)
        // swiftlint:disable all
        tablesQuery.staticTexts["Sample\t\t\t\tDuration:\t 00:01:30"].swipeLeft()
        // swiftlint:enable all
        tablesQuery.buttons["Delete"].tap()
        XCTAssertFalse(tablesQuery.staticTexts["Sample\t\t\t\tDuration:\t 00:01:30"].exists)
        logout()
    }
    func testUserCanAddTask() {
        login()
        sleep(1)
        application.buttons["Add Task"].tap()
        sleep(1)
        application.textFields["Task Title"].tap()
        application.textFields["Task Title"].typeText("Running")
        sleep(1)
        application.buttons["Return"].tap()
        sleep(1)
        snapshot("CreateTaskScreen")
        application.buttons["Create Task"].tap()
        sleep(1)
        application.buttons["Task List"].tap()
        sleep(2)
        logout()
    }
}
