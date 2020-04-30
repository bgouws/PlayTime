//
//  LoginUnitTest.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import Play_Time
@testable import PTFramework

class LoginUnitTest: XCTestCase {
    var accountManagement: AccountManagementViewModel!
    override func setUp() {
        accountManagement = AccountManagementViewModel()
        accountManagement.accountManagementRepo = AccountManagementRepoMock()
    }
    func testUserSuccessfulLogin() {
        accountManagement.login(email: "bgouws@gmail.com", password: "happydays")
    }
    func testUnsuccessfulLogin() {
        accountManagement.login(email: "bgougmail.com", password: "happydays")
    }
    func testSuccessfulSignUp() {
        accountManagement.signUp(email: "bgouws@gmail.com", password: "happydays")
    }
    func testUnsuccessfulSignUp() {
        accountManagement.signUp(email: "bgoumail.com", password: "happydays")
    }
    func testUserCanLogout() {
        accountManagement.signOut()
    }
}
