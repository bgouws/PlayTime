//
//  ValidationTest.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/03/30.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import Play_Time
@testable import PTFramework

class ValidationTest: XCTestCase {
    var myValid: Valid!
    override func setUp() {
        myValid = Valid()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserSuccessfulSignInValidation() {
        myValid.sign(inValidation: "brandongouws100@gmail.com", "happydays")
    }
    func testUserUnsuccessfulSignInValidation() {
        myValid.sign(inValidation: "brandon", "happydays")
    }
    func testUserSuccessfulSignUp() {
        myValid.signUpValidation("brandongouws100@gmail.com", "happydays", "happydays")
    }
    func testUserUnsuccessfulSignUp() {
        myValid.signUpValidation("b", "a", "c")
    }
}
