//
//  TaskManipulationMock.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import PTFramework

public class TaskManipulationRepoMock: TaskManipulationRepoType {
    public func addNewTask(newTask: Task, completion: @escaping (Result<Bool, Error>) -> Void) {
        if newTask.taskTitle == "Sample" {
            completion(.success(true))
        }
    }
    public func removeTask(newList: [Task], completion: @escaping (Result<Bool, Error>) -> Void) {
        if newList.isEmpty {
            completion(.failure(fatalError()))
        } else {
            completion(.success(true))
        }
    }
}
