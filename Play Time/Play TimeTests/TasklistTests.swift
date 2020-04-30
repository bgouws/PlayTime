//
//  TasklistTests.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
import PTFramework

class TasklistTests: XCTestCase {
    var taskListViewModel: TaskListViewModel!
    override func setUp() {
        taskListViewModel = TaskListViewModel()
        taskListViewModel.repo = TaskListRepoMock()
    }
    func testCanGetTaskList() {
        taskListViewModel.getListOfTasks()
    }
}
