//
//  MusicTasteSelectionTest.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/03/30.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import Play_Time
@testable import PTFramework

class MusicTasteSelectionTest: XCTestCase {
    var tasteSelectionUnderTest: PTTasteSelection!
    override func setUp() {
        tasteSelectionUnderTest = PTTasteSelection()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCheckIfItemThatIsInListIsAlreadyThere() {
        let result = tasteSelectionUnderTest.ptCheckList(value: "Rock", taste: ["Rock", "Pop"])
        XCTAssert(result)
    }
    func testCheckIfItemThatIsNotInListIsAlreadyThere() {
        let result = tasteSelectionUnderTest.ptCheckList(value: "MathRock", taste: ["Rock", "Pop"])
        XCTAssert(!result)
    }
}
