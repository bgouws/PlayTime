//
//  PlayMusicTest.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/03/09.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import PTFramework

class PlayMusicTest: XCTestCase {
    var playMusicUnderTest: PTPlayMusic!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        playMusicUnderTest = PTPlayMusic()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetsDataFromViewModel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
