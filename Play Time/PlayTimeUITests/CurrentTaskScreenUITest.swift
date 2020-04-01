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
        sleep(2)
    }
    func testUserCanStartAndStopTimer() {
        login()
        let tablesQuery = application.tables
        sleep(8)
        // swiftlint:disable all
        tablesQuery.staticTexts["Sample\t\t\t\tDuration:\t 00:01:30"].tap()
        // swiftlint:enable all
        sleep(4)
        let timer = XCUIApplication()
        timer.buttons["Start"].tap()
        sleep(2)
        timer.buttons["Stop"].tap()
        timer.buttons["Task List"].tap()
        sleep(2)
        logout()
    }
    func testUserCanResetTimer() {
        login()
        let tablesQuery = application.tables
        sleep(8)
        // swiftlint:disable all
        tablesQuery.staticTexts["Sample\t\t\t\tDuration:\t 00:01:30"].tap()
        // swiftlint:enable all
        sleep(4)
        let timer = XCUIApplication()
        timer.buttons["Start"].tap()
        sleep(2)
        timer.buttons["Reset"].tap()
        timer.buttons["Task List"].tap()
        sleep(2)
        logout()
    }
    func testUserCanGoToNextTrack() {
        login()
        let tablesQuery = application.tables
        sleep(8)
        // swiftlint:disable all
        tablesQuery.staticTexts["Sample\t\t\t\tDuration:\t 00:01:30"].tap()
        // swiftlint:enable all
        sleep(4)
        let timer = XCUIApplication()
        timer.buttons["Start"].tap()
        sleep(2)
        timer.buttons["Next Track"].tap()
        sleep(4)
        timer.buttons["Task List"].tap()
        sleep(2)
        logout()
    }
    func testTimerWillStopWhenItReachedCorrectInterval() {
        login()
        let tablesQuery = application.tables
        sleep(8)
        // swiftlint:disable all
        tablesQuery.staticTexts["Sample\t\t\t\tDuration:\t 00:01:30"].tap()
        // swiftlint:enable all
        sleep(4)
        let timer = XCUIApplication()
        timer.buttons["Start"].tap()
        sleep(100)
        timer.buttons["Task List"].tap()
        sleep(2)
        logout()
    }
}
