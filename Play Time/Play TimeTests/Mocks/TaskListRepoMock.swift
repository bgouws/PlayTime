//
//  TaskListRepoMock.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import PTFramework

public class TaskListRepoMock: TaskListRepoType {
    var listOfTask: [Task] = []
    public func getTaskList(completion: @escaping (Result<[Task], Error>) -> Void) {
        completion(.success(listOfTask))
    }
}
