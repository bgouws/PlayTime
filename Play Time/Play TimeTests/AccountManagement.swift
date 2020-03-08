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
    var accountManagemntUnderTest : MockSignUp!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        accountManagemntUnderTest = MockSignUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserSuccessfulLogout() {
        //accountManagemntUnderTest.ptSignOut()
    }
    
    func testUserSuccessfullyCallSignUp() {
        accountManagemntUnderTest.ptSignUp(email: "Matty@gmail.com", password: "happydays", conPassword: "happydays") { (success, data) in
//            guard let data = data else {
//                XCTFail()
//                return
//            }
            XCTAssertNotNil(data)
        }
    }
    
    func testUserUnsuccessfulSignUp() {
        accountManagemntUnderTest.ptSignUp(email: "bademail", password: "bad", conPassword: "good") { (success, data) in
        XCTAssertFalse(success)
        XCTAssertNil(data)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
