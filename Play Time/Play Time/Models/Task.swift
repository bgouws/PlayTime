//
//  Task.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/18.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import UIKit

class Task {
    var title: String
    var hour: String
    var minute: String
    var second: String
    init(title: String, hour: String, minute: String, second: String) {
        self.title = title
        self.hour = hour
        self.minute = minute
        self.second = second
    }
}
