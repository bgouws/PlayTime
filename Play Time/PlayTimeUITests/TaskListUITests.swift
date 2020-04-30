//
//  TaskListUITests.swift
//  PlayTimeUITests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest

class TaskListUITests: XCTestCase {
    var application: XCUIApplication!
    func login() {
        application.textFields["Email"].tap()
        application.textFields["Email"].typeText("uitests@gmail.com")
        application.secureTextFields["Password"].tap()
        application.secureTextFields["Password"].typeText("happydays")
        application.buttons["Login"].tap()
        sleep(8)
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
    func testUserCanTapTaskAndNavigate() {
        login()
        application.tables.staticTexts["Sample"].tap()
        snapshot("TaskListScreen")
        sleep(4)
        XCTAssert(application.staticTexts["Timer View"].exists)
        application.navigationBars["Timer View"].buttons["Task List"].tap()
        logout()
    }
    func testUserCanAddANewTask() {
        login()
        application.buttons["Add Task"].tap()
        sleep(2)
        snapshot("AddTaskScreen")
        application.textFields["Task Title"].tap()
        application.textFields["Task Title"].typeText("TestTask")
        application.buttons["Return"].tap()
        application.buttons["Create Task"].tap()
        sleep(10)
        XCTAssert(application.staticTexts["TestTask"].exists)
        let tablesQuery = XCUIApplication().tables
        tablesQuery.staticTexts["00:00:00"].swipeLeft()
        tablesQuery.cells.containing(.staticText, identifier: "TestTask").buttons["trailing0"].tap()
        XCTAssertFalse(application.staticTexts["TestTask"].exists)
        logout()
    }
    func testUserCanNavigateToFavourites() {
        login()
        application.buttons["Favourites"].tap()
        snapshot("FavouritesScreen")
        XCTAssert(application.staticTexts["Favourites"].exists)
        application.buttons["Task List"].tap()
        logout()
    }
}
