//
//  CreateTaskViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/18.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class CurrentTaskViewController: UIViewController {

    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    var timer = Timer()
    var isTimerRunning = false
    var counter = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStart.customButton()
        btnStop.customButton()
        btnReset.customButton()
        btnStop.isEnabled = false
        btnReset.isEnabled = false
        // Do any additional setup after loading the view.
    }
    @IBAction func btnStart(_ sender: Any) {
        if !isTimerRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                         selector: #selector(runTimer), userInfo: nil, repeats: true)
            isTimerRunning = true
            btnStop.isEnabled = true
            btnReset.isEnabled = true
            btnStart.isEnabled = false
            timerLabel.textColor = UIColor.black
        }
    }
    // MARK: Helper Methods
    @objc
    func runTimer() {
        counter += 0.1
        var minuteString = ""
        var secondString = ""
        var hourString = ""
        let flooredCounter = Int(floor(counter))
        let hour = flooredCounter / 3600
        let minute = (flooredCounter % 36000) / 60
        hourString = "\(hour)"
        if hour < 10 {
            hourString = "0\(hour)"
        }
        minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        let second = (flooredCounter % 3600) % 60
        secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        timerLabel.text = "\(hourString):\(minuteString):\(secondString)"
        if minuteString == "00" && secondString == "15"{
            timerLabel.textColor = UIColor.systemGreen
            isTimerRunning = false
            timer.invalidate()
        }
    }
    @IBAction func btnStop(_ sender: Any) {
        timerLabel.textColor = UIColor.red
        isTimerRunning = false
        timer.invalidate()
        btnStart.isEnabled = true
        btnStop.isEnabled = false
    }
    @IBAction func btnReset(_ sender: Any) {
        timerLabel.textColor = UIColor.black
        isTimerRunning = false
        timer.invalidate()
        counter = 0.0
        timerLabel.text = "00:00:00"
        btnStart.isEnabled = true
        btnReset.isEnabled = false
        btnStop.isEnabled = false
    }
}
