//
//  PlayMusicTest.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/03/30.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import Play_Time
@testable import PTFramework

class PlayMusicTest: XCTestCase {
    var playMusicUnderTest: PTPlayMusic!
    override func setUp() {
        playMusicUnderTest = PTPlayMusic()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    func testCanSetData() {
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
