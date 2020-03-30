//
//  ProfileTest.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/03/30.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import Play_Time
@testable import PTFramework

class ProfileTest: XCTestCase {
    var myProfileViewModel: ProfileViewModel!
    override func setUp() {
        myProfileViewModel = ProfileViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserCanGetFirstName() {
        myProfileViewModel.getFirstName()
    }
    func testUserCanGetLastName() {
        myProfileViewModel.getLastName()
    }
    func testUserCanGetBio() {
        myProfileViewModel.getBio()
    }
}
