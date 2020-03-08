//
//  TasteSelectionTest.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/03/08.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import XCTest
@testable import Play_Time
@testable import PTFramework

class TasteSelectionTest: XCTestCase {
    var tasteSelectionUnderTest: PTTasteSelection!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tasteSelectionUnderTest = PTTasteSelection()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveUserMusicTaste() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        tasteSelectionUnderTest.ptSaveMusicTaste(taste: ["data,data,data"])
    }
    func testCheckIfItemThatIsInListIsAlreadyThere() {
        let result = tasteSelectionUnderTest.ptCheckList(value: "Rock", taste: ["Rock", "Pop"])
        XCTAssert(result)
    }
    func testCheckIfItemThatIsNotInListIsAlreadyThere() {
        let result = tasteSelectionUnderTest.ptCheckList(value: "MathRock", taste: ["Rock", "Pop"])
        XCTAssert(!result)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
