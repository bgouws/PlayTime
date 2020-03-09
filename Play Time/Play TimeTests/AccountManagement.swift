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
    var variableAccess: MockSignUp!
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
            XCTAssertNotNil(data)
        }
    }
    
    func testUserUnsuccessfulSignUp() {
        accountManagemntUnderTest.ptSignUp(email: "bademail", password: "bad", conPassword: "good") { (success, data) in
        XCTAssertFalse(success)
        XCTAssertNil(data)
        }
    }
    
    func testUserSuccessfullySignedIn() {
        accountManagemntUnderTest.ptSignIn(email: "brandongouws100@gmail.com", password: "happydays") { (success, data) in
            XCTAssert(success)
            XCTAssertNotNil(data)
        }
    }
    
    func testUserUnsuccessfullySignedIn() {
        accountManagemntUnderTest.ptSignIn(email: "brandongouws100gmail.com", password: "") { (success, data) in
            XCTAssertFalse(success)
            XCTAssertNil(data)
        }
    }
    
    func testUserSuccessfulSignOut() {
        accountManagemntUnderTest.successfulLogout = true
        let result = accountManagemntUnderTest.ptSignOut()
        XCTAssert(result)
    }
    
    func testUserUnsuccessfulSignOut() {
        accountManagemntUnderTest.successfulLogout = false
        let result = accountManagemntUnderTest.ptSignOut()
        XCTAssertFalse(result)
    }
}
