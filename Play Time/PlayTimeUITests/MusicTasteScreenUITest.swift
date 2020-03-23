//
//  MusicTasteScreenUITest.swift
//  PlayTimeUITests
//
//  Created by Brandon Gouws on 2020/03/17.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest

class MusicTasteScreenUITest: XCTestCase {
    var application: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false
        application = XCUIApplication()
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserCanSelectMusicTaste() {
        application.buttons["Sign Up"].tap()
        application.textFields["Email"].tap()
        UIPasteboard.general.string = "testUser@gmail.com"
        application.textFields["Email"].tap()
        application.textFields["Email"].tap()
        application.menuItems["Paste"].tap()
        application.secureTextFields["Password"].tap()
        UIPasteboard.general.string = "happydays"
        application.secureTextFields["Password"].tap()
        application.menuItems["Paste"].tap()
        application.secureTextFields["Confirm Password"].tap()
        UIPasteboard.general.string = "happydays"
        application.secureTextFields["Confirm Password"].tap()
        application.menuItems["Paste"].tap()
        application.buttons["Create Account"].tap()
        sleep(4)
        application.buttons["Rock"].tap()
        sleep(1)
        application.buttons["Pop"].tap()
        sleep(1)
        application.buttons["Indie"].tap()
        sleep(1)
        application.buttons["Hip Hop"].tap()
        sleep(1)
        application.buttons["Country"].tap()
        sleep(1)
        application.buttons["Jazz"].tap()
        sleep(1)
        application.buttons["Rock"].tap()
        sleep(1)
        application.buttons["Pop"].tap()
        sleep(1)
        application.buttons["Indie"].tap()
        sleep(1)
        application.buttons["Hip Hop"].tap()
        sleep(1)
        application.buttons["Country"].tap()
        sleep(1)
        application.buttons["Jazz"].tap()
        sleep(1)
        XCTAssert(application.staticTexts["Start Working"].exists)
        application.buttons["Start Working"].tap()
        application.buttons["Logout"].tap()
        let elementsQuery = application.sheets.scrollViews.otherElements
        elementsQuery.buttons["Sign Out"].tap()
    }

}
