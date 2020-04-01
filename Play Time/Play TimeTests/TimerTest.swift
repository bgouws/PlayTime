//
//  TimerTest.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/03/30.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import Play_Time
@testable import PTFramework

class TimerTest: XCTestCase {
    var timerUnderTest: PTTimer!
    var playMusicSetUp: PTPlayMusic!
    override func setUp() {
        timerUnderTest = PTTimer()
        playMusicSetUp = PTPlayMusic()
        PTPlayMusic.setData(artist: ["data", "data", "data", "data",
                                     "data", "data", "data", "data",
                                     "data", "data", "data", "data",
                                     "data", "data"],
                            title: ["data", "data", "data", "data",
                                    "data", "data", "data", "data",
                                    "data", "data", "data", "data",
                                    "data", "data", "data", "data", "data"],
                            previewURL: ["data", "data", "data", "data",
                                         "data", "data", "data", "data",
                                         "data", "data", "data", "data",
                                         "data", "data", "data", "data"],
                            artString: ["data", "data", "data",
                                        "data", "data", "data",
                                        "data", "data", "data",
                                        "data", "data", "data",
                                        "data", "data", "data", "data"])
    }
    override func tearDown() {
    }
    func testCanPerformInitialLoad() {
        let outPutArray = timerUnderTest.ptInit()
        sleep(10)
        XCTAssertNotNil(outPutArray)
        timerUnderTest.ptInitialLoad()
        sleep(10)
    }
    func testUserCanPlayMusicUsingStart() {
        let outPutArray = timerUnderTest.ptInit()
        XCTAssertNotNil(outPutArray)
        timerUnderTest.ptInitialLoad()
        sleep(10)
        let output = timerUnderTest.ptStart()
        XCTAssert(output)
    }
    func testUserCanPausePlayback() {
        let outPutArray = timerUnderTest.ptInit()
        XCTAssertNotNil(outPutArray)
        timerUnderTest.ptInitialLoad()
        sleep(10)
        let output = timerUnderTest.ptStop()
        XCTAssertFalse(output)
    }
    func testPlayBackCanBePaused() {
        let outPutArray = timerUnderTest.ptInit()
        XCTAssertNotNil(outPutArray)
        timerUnderTest.ptInitialLoad()
        sleep(10)
        timerUnderTest.ptStopPlayback()
    }
    func testTimerSetUpSuccessfully() {
        let timerRunning = timerUnderTest.timerSetUp()
        XCTAssert(timerRunning)
    }
    func testTrackSetUp() {
        let outPutArray = timerUnderTest.ptInit()
        XCTAssertNotNil(outPutArray)
        timerUnderTest.ptInitialLoad()
        sleep(10)
        timerUnderTest.setupTrack()
    }
    func testMusicStopsWhenUserNavigatesBackToList() {
        let outPutArray = timerUnderTest.ptInit()
        XCTAssertNotNil(outPutArray)
        timerUnderTest.ptInitialLoad()
        sleep(10)
        let timerState = timerUnderTest.ptBackToList()
        XCTAssertFalse(timerState)
    }
    func testTimerStopsWhenTimerIsReset() {
        let outPutArray = timerUnderTest.ptInit()
        XCTAssertNotNil(outPutArray)
        timerUnderTest.ptInitialLoad()
        sleep(10)
        let timerState = timerUnderTest.ptResetTimer()
        XCTAssertFalse(timerState)
    }
}
