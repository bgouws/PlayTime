//
//  CreateTaskViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/18.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
//import MediaPlayer
import PTFramework
import AVFoundation
import CoreMedia

//Creating Variable
var ptTitle = ""
var ptArtist = ""
var ptArt = UIImage()
var ptPreview = ""
var count = 0

class CurrentTaskViewController: UIViewController {
    @IBOutlet weak var lblSongTitle: UILabel!
    @IBOutlet weak var lblSongArtist: UILabel!
    @IBOutlet weak var txtHeaderTask: UILabel!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var imgArtWork: UIImageView!
    var timer = Timer()
    var isTimerRunning = false
    var counter = 0.0
    var fHour = ""
    var fMinute = ""
    var fSecond = ""
    var fTitle = ""
    let myPTTimer = PTTimer()
    let myPTPlayMusic = PTPlayMusic()
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStart.customButton()
        btnStop.customButton()
        btnReset.customButton()
        btnBack.customButton()
        btnStop.isEnabled = false
        btnReset.isEnabled = false
        //Getting data from the viewModel
        let trackData = myPTTimer.ptInit()
        //Setting up first track
        //imgArtWork.image = trackData[2] as? UIImage
        imgArtWork.image = PTPlayMusic.getImage(count: count)
        lblSongTitle.text = trackData[0] as? String
        lblSongArtist.text = trackData[1] as? String
        txtHeaderTask.text = "Your Current Task: \(fTitle)"
        NotificationCenter.default.addObserver(self, selector: #selector(prepareNextTrack),
        name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    @objc func prepareNextTrack() {
        let trackData = myPTTimer.ptInit()
        //imgArtWork.image = trackData[2] as? UIImage
        count += 1
        print("Prepare next track has been called")
        imgArtWork.image = PTPlayMusic.getImage(count: count)
        lblSongTitle.text = trackData[0] as? String
        lblSongArtist.text = trackData[1] as? String
        myPTTimer.setupTrack()
    }
    @IBAction func btnStart(_ sender: Any) {
        print("Start Button Selected")
        if !myPTTimer.isTimerRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                         selector: #selector(runTimer), userInfo: nil, repeats: true)
        }
        myPTTimer.ptStart()
        btnStop.isEnabled = true
        btnStart.isEnabled = false
        btnReset.isEnabled = true
    }
    // MARK: Helper Methods
    @objc
    func runTimer() {
        //timerLabel.text = "\(hourString):\(minuteString):\(secondString)"
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
        //print("\(CMTimeGetSeconds(player!.currentTime()))")
        if hourString == fHour && minuteString == fMinute && secondString == fSecond {
            myPTTimer.ptStopPlayback()
            btnStop.isEnabled = false
            timerLabel.textColor = UIColor.systemGreen
            myPTTimer.isTimerRunning = false
            timer.invalidate()
        }
    }
    @IBAction func btnStop(_ sender: Any) {
        myPTTimer.ptStop()
        btnStart.isEnabled = true
        btnStop.isEnabled = false
        myPTTimer.isTimerRunning = false
        timer.invalidate()
    }
    @IBAction func btnBack(_ sender: Any) {
        myPTTimer.ptBackToList()
        timer.invalidate()
        timerLabel.text = "00:00:00"
        self.performSegue(withIdentifier: "backListView", sender: self)
    }
    @IBAction func btnReset(_ sender: Any) {
        myPTTimer.ptResetTimer()
        timer.invalidate()
        counter = 0.0
        timerLabel.textColor = UIColor.black
        timerLabel.text = "00:00:00"
        btnStart.isEnabled = true
        btnReset.isEnabled = false
        btnStop.isEnabled = false
    }
}
