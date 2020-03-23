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
        application.launch()
    }
    func testUserCanSuccessfullyAddAnItemToTheList() {
        application.textFields["Email"].tap()
        application.textFields["Email"].typeText("brandongouws100@gmail.com")
        application.secureTextFields["Password"].tap()
        application.secureTextFields["Password"].typeText("happydays")
        application.buttons["Sign In"].tap()
        sleep(4)
        let app = XCUIApplication()
        sleep(4)
        app.textFields["Task Title"].tap()
        sleep(4)
        app.textFields["Task Title"].typeText("Some Task")
        app.textFields["Duration - 00:00:00"].tap()
        app.textFields["Duration - 00:00:00"].typeText("00:00:10")
        sleep(2)
        app.buttons["Add Task"].tap()
        sleep(2)
        let tablesQuery = app.tables
        sleep(2)
        XCTAssert(tablesQuery.staticTexts["Some Task\t\t\t\tDuration:\t 00:00:10"].exists)
        application.buttons["Logout"].tap()
        let elementsQuery = application.sheets.scrollViews.otherElements
        elementsQuery.buttons["Sign Out"].tap()
    }
    func testUserCanDeleteAnItemFromList() {
        application.textFields["Email"].tap()
        application.textFields["Email"].typeText("brandongouws100@gmail.com")
        application.secureTextFields["Password"].tap()
        application.secureTextFields["Password"].typeText("happydays")
        application.buttons["Sign In"].tap()
        sleep(2)
        let app = XCUIApplication()
        let tablesQuery = app.tables
        // swiftlint:disable all
        tablesQuery.staticTexts["Working\t\t\t\tDuration:\t 02:30:00"].swipeLeft()
        // swiftlint:enable all
        tablesQuery.buttons["Delete"].tap()
        XCTAssertFalse(tablesQuery.staticTexts["Working\t\t\t\tDuration:\t 02:30:00"].exists)
        application.buttons["Logout"].tap()
        let elementsQuery = application.sheets.scrollViews.otherElements
        elementsQuery.buttons["Sign Out"].tap()
    }
    override func tearDown() {

    }
}
