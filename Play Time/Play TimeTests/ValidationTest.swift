//
//  Play_TimeTests.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/02/04.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import Play_Time
@testable import PTFramework
//swiftlint:disable all
class Play_TimeTests: XCTestCase {
//swiftlint:enable all
    var systemUnderTest: PTAccountManagement!
    var validationUnderTest: PTValidation!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //systemUnderTest = PTAccountManagement()
        validationUnderTest = PTValidation()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserVaidationSignInCorrect() {
        let email = "brandongouws100@gmail.com"
        let password = "happydays"
        let result = validationUnderTest.ptValidationCheckSignIn(email: email, password: password)
        XCTAssert(result)
    }
    func testUserVaidationSignInIncorrect() {
        let email = "bradongouws100gmail.com"
        let password = ""
        let result = validationUnderTest.ptValidationCheckSignIn(email: email, password: password)
        XCTAssert(!result)
    }
    func testUserValidationSignUpCorrect() {
        let email = "brandongouws100@gmail.com"
        let password = "happydays"
        let conPassword = "happydays"
        let result = validationUnderTest.ptValidationCheckSignUp(email: email,
                                                                 password: password, conPassword: conPassword)
        XCTAssert(result)
    }
    func testUserValidationSignUpIncorrect() {
        let email = "brandongouws100gmail.com"
        let password = "happydays"
        let conPassword = "saddays"
        let result = validationUnderTest.ptValidationCheckSignUp(email: email,
                                                                 password: password, conPassword: conPassword)
        XCTAssert(!result)
    }
}
