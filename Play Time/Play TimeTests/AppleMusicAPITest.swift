//
//  AppleMusicAPITest.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import Play_Time
@testable import PTFramework
import OHHTTPStubs
// swiftlint:disable all
class AppleMusicAPITest: XCTestCase {
    var condition = 0
    var appleMusicAPI: MusicListRepo!
    var musicList: MusicListViewModel!
    override func setUp() {
        stub(condition: isHost("itunes.apple.com")) { _ in
            switch self.condition {
            case 0:
                let stubPath = OHPathForFile("Tracks.json", type(of: self))
                return HTTPStubsResponse(fileAtPath: stubPath!,
                                         statusCode: 200,
                                         headers: ["Content-Type": "application/json"])
            default:
                print("Trigger Fail")
                return HTTPStubsResponse()
            }
        }
    }
    func testUserCanGetData() {
        condition = 0
        appleMusicAPI = MusicListRepo(genre: "Rock")
        appleMusicAPI.getListOfTracks { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                print("Stub success")
            case .failure(let error):
                XCTFail("stub failed")
            }
        }
    }
    func testCanGetTracksToPopulateCurrentTaskViewSuccess() {
        musicList = MusicListViewModel()
        musicList.repo = MusicListRepoMock(genre: "notRock")
        musicList.getListOfTracks(index: 0, indexUpNext: 1)
    }
    func testCanGetTracksToPopulateCurrentTaskViewUnsuccess() {
        musicList = MusicListViewModel()
        musicList.repo = MusicListRepoMock(genre: "Rock")
        musicList.getListOfTracks(index: 0, indexUpNext: 1)
    }
}
