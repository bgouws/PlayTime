//
//  TaskManipulationTests.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import XCTest
import PTFramework

class TaskManipulationTests: XCTestCase {
    var taskManipulationViewModel: TaskManipulationViewModel!
    override func setUp() {
        taskManipulationViewModel = TaskManipulationViewModel()
        taskManipulationViewModel.repo = TaskManipulationRepoMock()
    }
    func testCanAddANewTask() {
        let newTask: Task = Task(taskTitle: "Sample",
                                 taskHour: "00",
                                 taskMinute: "00",
                                 taskSecond: "00",
                                 location: "Johannesburg")
        taskManipulationViewModel.addNewItem(newTask: newTask)
    }
    func testCanRemoveTask() {
        var list: [Task] = []
        let newTask: Task = Task(taskTitle: "Sample",
        taskHour: "00",
        taskMinute: "00",
        taskSecond: "00",
        location: "Johannesburg")
        list.append(newTask)
        taskManipulationViewModel.removeTask(newList: list)
    }
}
