//
//  CurrentTaskScreenUITest.swift
//  PlayTimeUITests
//
//  Created by Brandon Gouws on 2020/03/17.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest

class CurrentTaskScreenUITest: XCTestCase {
    var application: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false
        application = XCUIApplication()
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testUserCanStartAndStopTimer() {
        application.textFields["Email"].tap()
        application.textFields["Email"].typeText("brandongouws100@gmail.com")
        application.secureTextFields["Password"].tap()
        application.secureTextFields["Password"].typeText("happydays")
        application.buttons["Sign In"].tap()
        sleep(2)
        let app = XCUIApplication()
        let tablesQuery = app.tables
        // swiftlint:disable all
        tablesQuery.staticTexts["Working\t\t\t\tDuration:\t 02:30:00"].tap()
        // swiftlint:enable all
        sleep(2)
        let timer = XCUIApplication()
        timer.buttons["Start"].tap()
        sleep(2)
        timer.buttons["Stop"].tap()
        timer.buttons["Back"].tap()
        application.buttons["Logout"].tap()
        let elementsQuery = application.sheets.scrollViews.otherElements
        elementsQuery.buttons["Sign Out"].tap()
    }
    func testUserCanResetTimer() {
        application.textFields["Email"].tap()
        application.textFields["Email"].typeText("brandongouws100@gmail.com")
        application.secureTextFields["Password"].tap()
        application.secureTextFields["Password"].typeText("happydays")
        application.buttons["Sign In"].tap()
        sleep(2)
        let app = XCUIApplication()
        let tablesQuery = app.tables
        // swiftlint:disable all
        tablesQuery.staticTexts["Working\t\t\t\tDuration:\t 02:30:00"].tap()
        // swiftlint:enable all
        sleep(2)
        let timer = XCUIApplication()
        timer.buttons["Start"].tap()
        sleep(2)
        timer.buttons["Stop"].tap()
        timer.buttons["Reset"].tap()
        timer.buttons["Back"].tap()
        application.buttons["Logout"].tap()
        let elementsQuery = application.sheets.scrollViews.otherElements
        elementsQuery.buttons["Sign Out"].tap()
    }
    func testTimerWillStopWhenItReachedCorrectInterval() {
        application.textFields["Email"].tap()
        application.textFields["Email"].typeText("brandongouws100@gmail.com")
        application.secureTextFields["Password"].tap()
        application.secureTextFields["Password"].typeText("happydays")
        application.buttons["Sign In"].tap()
        let app = XCUIApplication()
        sleep(2)
        app.textFields["Task Title"].tap()
        sleep(2)
        app.textFields["Task Title"].typeText("Test")
        app.textFields["Duration - 00:00:00"].tap()
        sleep(2)
        app.textFields["Duration - 00:00:00"].typeText("00:00:48")
        sleep(2)
        app.buttons["Add Task"].tap()
        sleep(2)
        let tablesQuery = app.tables
        sleep(2)
        tablesQuery.staticTexts["Test\t\t\t\tDuration:\t 00:00:48"].tap()
        let timer = XCUIApplication()
        sleep(4)
        timer.buttons["Start"].tap()
        sleep(50)
        sleep(2)
        timer.buttons["Back"].tap()
        sleep(2)
        application.buttons["Logout"].tap()
        let elementsQuery = application.sheets.scrollViews.otherElements
        elementsQuery.buttons["Sign Out"].tap()
    }

}
