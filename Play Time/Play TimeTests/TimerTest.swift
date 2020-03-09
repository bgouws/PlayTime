//
//  TimerTest.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/03/09.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import PTFramework

class TimerTest: XCTestCase {
    var timerUnderTest: PTTimer!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        timerUnderTest = PTTimer()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessfullyLoadNextTrack() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let audioItem = timerUnderTest.loadNextTrack()
        XCTAssertNotNil(audioItem)
    }
    func testUnsuccessfullyLoadedNextTrack() {
    }
    func testStopedMusic() {
        let result = timerUnderTest.ptStop()
        XCTAssertFalse(result)
    }
    func testMusicStartedPlaying() {
        _ = timerUnderTest.loadNextTrack()
        let result = timerUnderTest.ptStart()
        XCTAssert(result)
    }
    func testMusicPlayerReset() {
        let result = timerUnderTest.ptResetTimer()
        XCTAssertFalse(result)
    }
    func testUserNavigatesBackToList() {
        _ = timerUnderTest.loadNextTrack()
        _ = timerUnderTest.ptStart()
        let result = timerUnderTest.ptBackToList()
        XCTAssertFalse(result)
    }
    func testTimerIsRunningSuccessfully() {
        let result = timerUnderTest.timerSetUp()
        XCTAssert(result)
    }
}
