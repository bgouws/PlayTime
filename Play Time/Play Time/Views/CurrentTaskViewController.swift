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
import WatchConnectivity

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
    var session: WCSession?
    //Objects
    let myCurrentTaskAnalytics = CurrentTaskAnalytics()
    var musicListViewModel = MusicListViewModel()
    var favouritesViewModel = FavouritesViewModel()
    var nowPlaying = FavTrack(artistName: "default", trackTitle: "default",
                              artworkUrl100: "default", previewUrl: "default")
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
        self.favouritesViewModel.view = self
        self.favouritesViewModel.repo = FavouritesRepo()
        self.musicListViewModel.getListOfTracks(index: trackIndex, indexUpNext: trackIndex + 1)
        NotificationCenter.default.addObserver(self, selector: #selector(nextTrack),
        name: .AVPlayerItemDidPlayToEndTime, object: nil)
        self.configureWatchKitSession()
        sendWatchPlayerStatus()
    }
    func configureWatchKitSession() {
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
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
        isTimerRunning = false
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
    private func startTimer() {
        myCurrentTaskAnalytics.musicStart()
        styleTimerOn()
        player?.play()
        toggleTimers()
    }
    private func stopTimer() {
        styleTimerPaused()
        myCurrentTaskAnalytics.musicPause()
        player?.pause()
        toggleTimers()
    }
    private func sendWatchPlayerStatus() {
        if let validSession = self.session, validSession.isReachable {
            let playerStatus: [String: Bool] = ["playerStatus": isTimerRunning]
            validSession.sendMessage(playerStatus, replyHandler: nil, errorHandler: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Timer View"
    }
    // MARK: Button IBActions
    @IBAction func btnStart(_ sender: Any) {
        startTimer()
    }
    @IBAction func btnStop(_ sender: Any) {
        stopTimer()
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
        self.favouritesViewModel.saveTrack(track: nowPlaying)
    }
    private func trackInfoToWatch(trackTitle: String, trackArtist: String, albumArt: UIImage) {
        let imageData = albumArt.pngData()
        if let validSession = self.session, validSession.isReachable {
            let trackInfo: [String: [Any]] = ["TrackInfo": ["\(trackTitle)", "\(trackArtist)", imageData!]]
            validSession.sendMessage(trackInfo, replyHandler: nil, errorHandler: nil)
        }
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
            if let validSession = self.session, validSession.isReachable {
                let timerData: [String: String] = ["timerValue": "Task is complete"]
                validSession.sendMessage(timerData, replyHandler: nil, errorHandler: nil)
            }
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
        trackInfoToWatch(trackTitle: currentTitle, trackArtist: currentArtist, albumArt: currentAlbumArt)
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
        sendWatchPlayerStatus()
        manageTimer()
    }
    func setNowPlaying(nowPlaying: TrackDetails) {
        self.nowPlaying.trackTitle = nowPlaying.trackName
        self.nowPlaying.artistName = nowPlaying.artistName
        self.nowPlaying.artworkUrl100 = nowPlaying.artworkUrl100
        self.nowPlaying.previewUrl = nowPlaying.previewUrl
    }
}
extension CurrentTaskViewController: MusicListViewType {
    func loadCurrentTrack(currentTrack: TrackDetails) {
        if let image = UIImage(urlString: currentTrack.artworkUrl100) {
            DispatchQueue.main.async {
                self.setCurrentTrack(currentTitle: currentTrack.trackName,
                                     currentArtist: currentTrack.artistName, currentAlbumArt: image)
                self.setNowPlaying(nowPlaying: currentTrack)
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
extension CurrentTaskViewController: WCSessionDelegate {
  func sessionDidBecomeInactive(_ session: WCSession) {
  }
  func sessionDidDeactivate(_ session: WCSession) {
  }
  func session(_ session: WCSession,
               activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
  }
  func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
    DispatchQueue.main.async {
      if let value = message["PlayerRequest"] as? String {
        switch value {
        case "Pause":
            self.stopTimer()
        case "Play":
            self.startTimer()
        case "NextTrack":
            self.nextTrack()
        default:
            self.showAlert(title: "Error", desc: "Unknow watch command")
        }
      }
    }
  }
}
extension CurrentTaskViewController: FavouritesViewType {
    func removedSingleItem(isRemoved: Bool) {
    }
    func displayCoreDataError(error: Error) {
        showAlert(title: "Error", desc: error.localizedDescription)
    }
    func saveNewFavourite(saved: Bool) {
        if saved {
            showAlert(title: "Added to favourites", desc: "Track added to you favourites.")
        } else {
            showAlert(title: "Error", desc: "Unable to save to favourites")
        }
    }
    func displayFavCleared(listCleared: Bool) {
    }
    func getFavouriteList(list: [FavTrack]) {
        //Will compare list here
    }
    func saveNewFavourite() {
        showAlert(title: "Favourites", desc: "Track added to favourites")
    }
}
