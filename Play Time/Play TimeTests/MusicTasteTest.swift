//
//  MusicTasteTest.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import Play_Time
@testable import PTFramework
var musicTaste: MusicTasteViewModel!
class MusicTasteTest: XCTestCase {
    override func setUp() {
        musicTaste = MusicTasteViewModel()
        musicTaste.repo = MusicTasteRepoMock()
    }
    func testCanGetMusicTaste() {
        musicTaste.getMusicTaste()
    }
    func testCanSetUserTasteSuccessfully() {
        musicTaste.storeTaste(tasteList: ["rock", "pop"])
    }
    func testCanSetUserTasteUnsuccessfully() {
        musicTaste.storeTaste(tasteList: ["metal", "mathRock"])
    }
}
