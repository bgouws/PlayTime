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
        let moreKey = application.keys["more"]
        application.textFields["Email"].tap()
        application.tapKeys(text: "brandongouws")
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
        let moreKey = application.keys["more"]
        application.textFields["Email"].tap()
        application.tapKeys(text: "brandongouws")
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
//    func testTimerWillStopWhenItReachedCorrectInterval() {
//        application.launch()
//        let moreKey = application.keys["more"]
//        application.textFields["Email"].tap()
//        application.tapKeys(text: "brandongouws")
//        moreKey.tap()
//        application.keys["1"].tap()
//        application.keys["0"].tap()
//        application.keys["0"].tap()
//        application.keys["@"].tap()
//        application.keys["more"].tap()
//        application.tapKeys(text: "gmail")
//        moreKey.tap()
//        application.keys["."].tap()
//        moreKey.tap()
//        application.tapKeys(text: "com")
//        application.secureTextFields["Password"].tap()
//        application.tapKeys(text: "happydays")
//        application.buttons["Sign In"].tap()
//        let app = XCUIApplication()
//        let moreKeys = app.keys["more"]
//        sleep(2)
//        app.textFields["Task Title"].tap()
//        sleep(2)
//        app.keys["t"].tap()
//        app.keys["e"].tap()
//        app.keys["s"].tap()
//        app.keys["t"].tap()
//        app.textFields["Duration - 00:00:00"].tap()
//        sleep(2)
//        moreKeys.tap()
//        app.keys["0"].tap()
//        app.keys["0"].tap()
//        app.keys[":"].tap()
//        app.keys["0"].tap()
//        app.keys["0"].tap()
//        app.keys[":"].tap()
//        app.keys["4"].tap()
//        app.keys["8"].tap()
//        sleep(2)
//        app.buttons["Add Task"].tap()
//        sleep(2)
//        let tablesQuery = app.tables
//        sleep(2)
//        tablesQuery.staticTexts["test\t\t\t\tDuration:\t 00:00:48"].tap()
//        let timer = XCUIApplication()
//        timer.buttons["Start"].tap()
//        sleep(50)
//        sleep(2)
//        timer.buttons["Back"].tap()
//        sleep(2)
//        application.buttons["Logout"].tap()
//        let elementsQuery = application.sheets.scrollViews.otherElements
//        elementsQuery.buttons["Sign Out"].tap()
//    }

}
