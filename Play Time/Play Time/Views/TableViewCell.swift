//
//  TableViewCell.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/18.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import PTFramework

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lblTaskTitle: UILabel!
    @IBOutlet weak var lblTaskDuration: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!
    func setTask(task: Task) {
        lblTaskTitle.text = task.taskTitle
        lblTaskDuration.text = "\(task.taskHour):\(task.taskMinute):\(task.taskSecond)"
        lblLocation.text = task.location
    }
}
