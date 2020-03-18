//
//  TaskUnitTest.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/03/18.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import PTFramework

class TaskUnitTest: XCTestCase {
    var taskUnderTest: PTTask!
    override func setUp() {
        taskUnderTest = PTTask(title: "Running", hour: "00", minute: "00", second: "00")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanGetAllInformationOnTask() {
        XCTAssert(taskUnderTest.hour == "00")
        XCTAssert(taskUnderTest.minute == "00")
        XCTAssert(taskUnderTest.second == "00")
        XCTAssert(taskUnderTest.title == "Running")
    }
}
