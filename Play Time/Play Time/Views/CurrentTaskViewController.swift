//
//  CreateTaskViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/18.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import MediaPlayer

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
    var finalTitle = "Default"
    var finalArtist = "Default"
    let player = MPMusicPlayerController.applicationQueuePlayer
    var timer = Timer()
    var isTimerRunning = false
    var counter = 0.0
    var fHour = ""
    var fMinute = ""
    var fSecond = ""
    var fTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStart.customButton()
        btnStop.customButton()
        btnReset.customButton()
        btnBack.customButton()
        btnStop.isEnabled = false
        btnReset.isEnabled = false
        txtHeaderTask.text = "Your Current Task: \(fTitle)"
        // Do any additional setup after loading the view.
    }
    @IBAction func btnStart(_ sender: Any) {
        var finalURL: URL = URL(string: "google.com")!
        let query = MPMediaQuery.songs()
        //Setting up query filter
        let isPresent = MPMediaPropertyPredicate(value: "Rock", forProperty: MPMediaItemPropertyGenre,
                                                 comparisonType: .equalTo)
        //Adding the filter to the query
        query.addFilterPredicate(isPresent)
        guard let items = query.items else { return }
        let sTitles = items.filter {
            let titles = $0.genre
            return titles == "Rock"
        }
        for titles in sTitles {
            print("\(titles.artist!) : \(titles.albumTitle!) : \(titles.title!)")
        }
        let queue = MPMediaItemCollection(items: sTitles)
        // Code for image
        player.stop()
        player.setQueue(with: queue)
        player.play()
        let nowPlayingTitle = player.nowPlayingItem?.title
        let nowPlayingArtist = player.nowPlayingItem?.artist
        let currentTrackTitle = nowPlayingTitle!.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let currentTrackArtist = nowPlayingArtist!.replacingOccurrences(of: " ", with: "+",
                                                                        options: .literal, range: nil)
        var listOfTracks = [TrackDetails]()
        let myRequest = TrackRequest.init(trackTitle: currentTrackTitle, trackArtist: currentTrackArtist)
        myRequest.getData { result in
            switch result {
            case .failure(let error): print(error)
            case .success(let actualData): listOfTracks = actualData
            }
        let val = listOfTracks[0]
        print(val.artworkUrl100)
            finalURL = URL(string: val.artworkUrl100)!
            self.imgArtWork.load(url: finalURL)
        }
        self.finalTitle = (self.player.nowPlayingItem?.title)!
        self.finalArtist = (self.player.nowPlayingItem?.artist)!
        if !isTimerRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                         selector: #selector(runTimer), userInfo: nil, repeats: true)
            timerSetUp()
        }
            imgArtWork.load(url: finalURL)
            populateTrack()
    }
    func populateTrack() {
        lblSongTitle.text = finalTitle
        lblSongArtist.text = finalArtist
    }
    func timerSetUp() {
        isTimerRunning = true
        btnStop.isEnabled = true
        btnReset.isEnabled = true
        btnStart.isEnabled = false
        timerLabel.textColor = UIColor.black
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
        if hourString == fHour && minuteString == fMinute && secondString == fSecond {
            player.stop()
            timerLabel.textColor = UIColor.systemGreen
            isTimerRunning = false
            timer.invalidate()
        }
    }
    @IBAction func btnStop(_ sender: Any) {
        timerLabel.textColor = UIColor.red
        player.stop()
        isTimerRunning = false
        timer.invalidate()
        btnStart.isEnabled = true
        btnStop.isEnabled = false
    }
    @IBAction func btnBack(_ sender: Any) {
        player.stop()
        self.performSegue(withIdentifier: "backListView", sender: self)
    }
    @IBAction func btnReset(_ sender: Any) {
        player.stop()
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

extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
