//
//  UserAccountTest.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/03/30.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import Play_Time
@testable import PTFramework

class UserAccountTest: XCTestCase {
    var userAccountUnderTest: PTAccountManagement!
    override func setUp() {
        userAccountUnderTest = PTAccountManagement()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testUserCanLogin() {
        userAccountUnderTest.ptSignIn(email: "brandongouws100@gmail.com", password: "happydays") { (success, output) in
            XCTAssert(success)
            print(output)
        }
    }
    func testUserUnsuccessfulLogin() {
        userAccountUnderTest.ptSignIn(email: "brandongouws100gmail.com", password: "happydays") { (success, output) in
            XCTAssertFalse(success)
            print(output)
        }
    }
    func testUserCanSignUpSuccessfully() {
        userAccountUnderTest.ptSignUp(email: "charmaine@gmail.com", password: "happydays",
                                      conPassword: "happydays") { (success, output) in
            XCTAssert(success)
            print(output)
        }
    }
    func testUserCanSignUpUnsuccessfully() {
        userAccountUnderTest.ptSignUp(email: "charmaine", password: "happydays",
                                      conPassword: "happydays") { (success, output) in
            XCTAssertFalse(success)
            print(output)
        }
    }
    func testUserCanSignOutSuccessfully() {
        let output = userAccountUnderTest.ptSignOut()
        XCTAssert(output)
    }
}
