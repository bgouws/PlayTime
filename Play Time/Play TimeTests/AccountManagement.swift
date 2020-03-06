//
//  AccountManagement.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/03/05.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import XCTest
@testable import Play_Time
@testable import PTFramework
//swiftlint:disable all
class AccountManagement_Tests: XCTestCase {
    var signOutUnderTest : PTAccountManagement!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signOutUnderTest = PTAccountManagement()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserSuccessfulLogout() {
        signOutUnderTest.ptSignOut()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
