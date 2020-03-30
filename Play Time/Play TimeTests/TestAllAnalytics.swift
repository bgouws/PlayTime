//
//  TestAllAnalytics.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/03/30.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
@testable import Play_Time
@testable import PTFramework

class TestAllAnalytics: XCTestCase {
    var myAddNewTaskAnalytics: AddNewTaskAnalytics!
    var myCurrentTaskAnalytics: CurrentTaskAnalytics!
    var myLoginAnalytics: LoginAnalytics!
    var myMusicTasteAnalytics: MusicTasteAnalytics!
    var myProfileAnalytics: ProfileAnalytics!
    var mySignUpAnalytics: SignUpAnalytics!
    var myTaskListViewAnalytics: TaskListViewAnalytics!
    override func setUp() {
        myAddNewTaskAnalytics = AddNewTaskAnalytics()
        myCurrentTaskAnalytics = CurrentTaskAnalytics()
        myLoginAnalytics = LoginAnalytics()
        myMusicTasteAnalytics = MusicTasteAnalytics()
        myProfileAnalytics = ProfileAnalytics()
        mySignUpAnalytics = SignUpAnalytics()
        myTaskListViewAnalytics = TaskListViewAnalytics()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAllAnalytics() {
        myAddNewTaskAnalytics.addNewTask()
        myAddNewTaskAnalytics.pickerTimeSet()
        myCurrentTaskAnalytics.musicBackToList()
        myCurrentTaskAnalytics.musicPause()
        myCurrentTaskAnalytics.musicReset()
        myCurrentTaskAnalytics.musicStart()
        myCurrentTaskAnalytics.nextTrack()
        myCurrentTaskAnalytics.timerStarted()
        myCurrentTaskAnalytics.timerStopped()
        myLoginAnalytics.successfulLogin()
        myLoginAnalytics.unsuccessfulLogin()
        myMusicTasteAnalytics.musicTasteCountry()
        myMusicTasteAnalytics.musicTasteHipHop()
        myMusicTasteAnalytics.musicTasteIndie()
        myMusicTasteAnalytics.musicTasteJazz()
        myMusicTasteAnalytics.musicTastePop()
        myMusicTasteAnalytics.musicTasteRock()
        myMusicTasteAnalytics.musicTasteStored()
        myProfileAnalytics.loadedProfileData()
        myProfileAnalytics.setProfileData()
        myProfileAnalytics.profileTapped()
        mySignUpAnalytics.successfulSignUp()
        mySignUpAnalytics.unsuccessfulSignUp()
        myTaskListViewAnalytics.taskDeleted()
        myTaskListViewAnalytics.taskSelected()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
