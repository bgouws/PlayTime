//
//  TableViewCell.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/18.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    func setTask(task: Task) {
        lblTitle.text = "\(task.title)\t\t\t\tDuration:\t \(task.hour):\(task.minute):\(task.second)"
    }
}
