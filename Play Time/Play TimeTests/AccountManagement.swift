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
    var accountSystemUnderTest: PTAccountManagement!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mock = MockingLoginProtocol()
        accountSystemUnderTest = PTAccountManagement(view: mock)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginMock() {
        accountSystemUnderTest.ptSignUp(email: "brandongouws100@gmail.com", password: "happydays", conPassword: "happydays") { (success, data) in
            if data == "Successful SignUp" {
                XCTAssert(success)
            }
        }
    }
}
