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
        let moreKey = application.keys["more"]
        application.textFields["Email"].tap()
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
        moreKey.tap()
        application.keys["1"].tap()
        application.keys["0"].tap()
        application.keys["0"].tap()
        application.keys["@"].tap()
        application.keys["more"].tap()
        application.keys["g"].tap()
        application.keys["m"].tap()
        application.keys["a"].tap()
        application.keys["i"].tap()
        application.keys["l"].tap()
        moreKey.tap()
        application.keys["."].tap()
        moreKey.tap()
        application.keys["c"].tap()
        application.keys["o"].tap()
        application.keys["m"].tap()
        application.secureTextFields["Password"].tap()
        application.keys["h"].tap()
        application.keys["a"].tap()
        application.keys["p"].tap()
        application.keys["p"].tap()
        application.keys["y"].tap()
        application.keys["d"].tap()
        application.keys["a"].tap()
        application.keys["y"].tap()
        application.keys["s"].tap()
        application.buttons["Sign In"].tap()
        let app = XCUIApplication()
        let moreKeys = app.keys["more"]
        sleep(4)
        app.textFields["Task Title"].tap()
        sleep(4)
        app.keys["d"].tap()
        app.keys["a"].tap()
        app.keys["t"].tap()
        app.keys["a"].tap()
        app.textFields["Duration - 00:00:00"].tap()
        sleep(2)
        moreKeys.tap() 
        app.keys["0"].tap()
        app.keys["0"].tap()
        app.keys[":"].tap()
        app.keys["0"].tap()
        app.keys["0"].tap()
        app.keys[":"].tap()
        app.keys["1"].tap()
        app.keys["0"].tap()
        sleep(2)
        app.buttons["Add Task"].tap()
        sleep(2)
        let tablesQuery = app.tables
        sleep(2)
        XCTAssert(tablesQuery.staticTexts["data\t\t\t\tDuration:\t 00:00:10"].exists)
        application.buttons["Logout"].tap()
        let elementsQuery = application.sheets.scrollViews.otherElements
        elementsQuery.buttons["Sign Out"].tap()
    }
    func testUserCanDeleteAnItemFromList() {
        let moreKey = application.keys["more"]
        application.textFields["Email"].tap()
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
        moreKey.tap()
        application.keys["1"].tap()
        application.keys["0"].tap()
        application.keys["0"].tap()
        application.keys["@"].tap()
        application.keys["more"].tap()
        application.keys["g"].tap()
        application.keys["m"].tap()
        application.keys["a"].tap()
        application.keys["i"].tap()
        application.keys["l"].tap()
        moreKey.tap()
        application.keys["."].tap()
        moreKey.tap()
        application.keys["c"].tap()
        application.keys["o"].tap()
        application.keys["m"].tap()
        application.secureTextFields["Password"].tap()
        application.keys["h"].tap()
        application.keys["a"].tap()
        application.keys["p"].tap()
        application.keys["p"].tap()
        application.keys["y"].tap()
        application.keys["d"].tap()
        application.keys["a"].tap()
        application.keys["y"].tap()
        application.keys["s"].tap()
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
