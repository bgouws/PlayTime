//
//  CreateTaskViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/18.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import PTFramework
import AVFoundation

class CurrentTaskViewController: UIViewController {
    //Components
    @IBOutlet weak var lblArtistUpNext: UILabel!
    @IBOutlet weak var lblSongTitleUpNext: UILabel!
    @IBOutlet weak var imgUpNext: UIImageView!
    @IBOutlet weak var btnNextTrack: UIButton!
    @IBOutlet weak var viewCurrentTrack: UIView!
    @IBOutlet weak var viewNextUp: UIView!
    @IBOutlet weak var lblSongTitle: UILabel!
    @IBOutlet weak var lblSongArtist: UILabel!
    @IBOutlet weak var txtHeaderTask: UILabel!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var imgArtWork: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var actInCurrentTrack: UIActivityIndicatorView!
    @IBOutlet weak var actInNextTrack: UIActivityIndicatorView!
    //Objects
    let myCurrentTaskAnalytics = CurrentTaskAnalytics()
    var musicListViewModel = MusicListViewModel()
    //Variables
    var taskHour = ""
    var taskMinute = ""
    var taskSecond = ""
    var taskTitle = ""
    var isTimerRunning: Bool = false
    var trackIndex: Int = 0
    var timerCounter: Float = 0
    //AVPlayer
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    //Timer
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Styling and preparing view
        styleView()
        styleTimerOff()
        startLoadingIndicators()
        txtHeaderTask.text = "Your Current Task: \(taskTitle)"
        self.musicListViewModel.view = self
        self.musicListViewModel.repo = MusicListRepo()
        self.musicListViewModel.getListOfTracks(index: trackIndex, indexUpNext: trackIndex + 1)
        NotificationCenter.default.addObserver(self, selector: #selector(nextTrack),
        name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    // MARK: Style functions
    private func styleView() {
        btnStart.defaultButton()
        btnStop.defaultButton()
        btnReset.defaultButton()
        viewCurrentTrack.trackLayers()
        viewNextUp.trackLayers()
        btnNextTrack.defaultButton()
        imgArtWork.albumArtStyle()
        imgUpNext.albumArtStyle()
        btnLike.defaultButton()
    }
    private func styleTimerOff() {
        btnStart.isEnabled = true
        btnStop.isEnabled = false
        btnReset.isEnabled = false
        btnNextTrack.isEnabled = false
        timerLabel.textColor = UIColor.black
    }
    private func styleTimerPaused() {
        btnStart.isEnabled = true
        btnNextTrack.isEnabled = false
        btnStop.isEnabled = false
    }
    private func styleTimerOn() {
        btnStop.isEnabled = true
        btnStart.isEnabled = false
        btnReset.isEnabled = true
        btnNextTrack.isEnabled = true
    }
    private func styleTaskComplete() {
        btnStop.isEnabled = false
        btnStart.isEnabled = false
        btnReset.isEnabled = true
        btnNextTrack.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Timer View"
    }
    // MARK: Button IBActions
    @IBAction func btnStart(_ sender: Any) {
        myCurrentTaskAnalytics.musicStart()
        styleTimerOn()
        player?.play()
        toggleTimers()
    }
    @IBAction func btnStop(_ sender: Any) {
        styleTimerPaused()
        myCurrentTaskAnalytics.musicPause()
        player?.pause()
        toggleTimers()
    }
    @IBAction func btnReset(_ sender: Any) {
        styleTimerOff()
        player?.pause()
        timerLabel.text = "00:00:00"
        isTimerRunning = false
        timer.invalidate()
        trackIndex = -1
        timerCounter = 0
        nextTrack()
    }
    @IBAction func btnNexTrack(_ sender: Any) {
        nextTrack()
    }
    @IBAction func btnLikeTapped(_ sender: UIButton) {
    }
    // MARK: Helper Methods
    @objc
    func runTimer() {
        timerCounter += 0.1
        var minuteString = ""
        var secondString = ""
        var hourString = ""
        let flooredCounter = Int(floor(timerCounter))
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
        if hourString == taskHour && minuteString == taskMinute && secondString == taskSecond {
            timerLabel.textColor = UIColor.green
            player?.pause()
            toggleTimers()
            styleTaskComplete()
        }
    }
    private func showAlert(title: String, desc: String) {
        let alertController = UIAlertController(title: title, message:
            desc, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    private func setCurrentTrack(currentTitle: String, currentArtist: String, currentAlbumArt: UIImage) {
        lblSongTitle.text = currentTitle
        lblSongArtist.text = currentArtist
        imgArtWork.image = currentAlbumArt
    }
    private func setNextTrack(nextTitle: String, nextArtist: String, nextAlbumArt: UIImage) {
        lblSongTitleUpNext.text = nextTitle
        lblArtistUpNext.text = nextArtist
        imgUpNext.image = nextAlbumArt
    }
    private func stopLoadingIndicators() {
        actInCurrentTrack.stopAnimating()
        actInNextTrack.stopAnimating()
        actInCurrentTrack.isHidden = true
        actInNextTrack.isHidden = true
    }
    private func startLoadingIndicators() {
        actInCurrentTrack.startAnimating()
        actInNextTrack.startAnimating()
        actInCurrentTrack.isHidden = false
        actInNextTrack.isHidden = false
        lblSongTitle.text = "Loading..."
        lblSongArtist.text = "Loading..."
        lblSongTitleUpNext.text = "Loading..."
        lblArtistUpNext.text = "Loading..."
    }
    func manageTimer() {
        if isTimerRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
            selector: #selector(runTimer), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
        }
    }
    @objc
    public func nextTrack() {
        trackIndex += 1
        self.musicListViewModel.getListOfTracks(index: trackIndex, indexUpNext: trackIndex + 1)
    }
    func toggleTimers() {
        isTimerRunning = !isTimerRunning
        manageTimer()
    }
}
extension CurrentTaskViewController: MusicListViewType {
    func loadCurrentTrack(currentTrack: TrackDetails) {
        if let image = UIImage(urlString: currentTrack.artworkUrl100) {
            DispatchQueue.main.async {
                self.setCurrentTrack(currentTitle: currentTrack.trackName,
                                     currentArtist: currentTrack.artistName, currentAlbumArt: image)
                 self.stopLoadingIndicators()
             }
        }
        player = AVPlayer(playerItem: AVPlayerItem(url: URL(string: currentTrack.previewUrl)!))
        if isTimerRunning {
            player?.play()
        }
    }
    func loadNextTrack(nextTrack: TrackDetails) {
        if let image = UIImage(urlString: nextTrack.artworkUrl100) {
            DispatchQueue.main.async {
                self.setNextTrack(nextTitle: nextTrack.trackName,
                                  nextArtist: nextTrack.artistName, nextAlbumArt: image)
                 self.stopLoadingIndicators()
             }
        }
    }
    func displayError(error: String) {
        showAlert(title: "An error has occured", desc: error)
    }
}
extension UIImage {
    convenience init?(urlString: String) {
        guard let url = URL(string: urlString),
            let data = try? Data(contentsOf: url)
         else { return nil }
        self.init(data: data)
    }
}
