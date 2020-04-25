//
//  InterfaceController.swift
//  playtimewatch Extension
//
//  Created by Brandon Gouws on 2020/04/25.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import UIKit

class InterfaceController: WKInterfaceController {
    @IBOutlet weak var lblTaskStatus: WKInterfaceLabel!
    @IBOutlet weak var btnToggleTimer: WKInterfaceButton!
    @IBOutlet weak var btnNext: WKInterfaceButton!
    @IBOutlet weak var lblTrackTitle: WKInterfaceLabel!
    @IBOutlet weak var imgAlbumArt: WKInterfaceImage!
    @IBOutlet weak var lblTrackArtist: WKInterfaceLabel!
    let session = WCSession.default
    var currentStatus: Bool = false
    let greenColor = UIColor(red: 0.37, green: 0.58, blue: 0.33, alpha: 1.0)
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        session.delegate = self
        session.activate()
    }
    @IBAction func btnToggleTimerTapped() {
        var playerStatus: [String: String] = ["PlayerRequest": "Default"]
        if currentStatus {
            playerStatus = ["PlayerRequest": "Play"]
        } else {
            playerStatus = ["PlayerRequest": "Pause"]
        }
        session.sendMessage(playerStatus, replyHandler: nil, errorHandler: nil)
    }
    @IBAction func btnNextTapped() {
        if !currentStatus {
            let playerStatus: [String: String] = ["PlayerRequest": "NextTrack"]
            session.sendMessage(playerStatus, replyHandler: nil, errorHandler: nil)
        }
    }
    override func willActivate() {
        super.willActivate()
    }
    override func didDeactivate() {
        super.didDeactivate()
    }
    private func updateNegativeStatus() {
        lblTaskStatus.setText("Not in progress")
        btnToggleTimer.setTitle("Play")
        btnNext.setBackgroundColor(UIColor.lightGray)
    }
    private func updatePositiveStatus() {
        lblTaskStatus.setText("In Progress")
        btnToggleTimer.setTitle("Pause")
        btnNext.setBackgroundColor(greenColor)
    }
}
extension InterfaceController: WCSessionDelegate {
  func session(_ session: WCSession,
               activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
  }
  func session(_ session: WCSession,
               didReceiveMessage message: [String: Any]) {
    if let watchStatus = message["playerStatus"] as? Bool {
        if watchStatus {
            updatePositiveStatus()
        } else {
            updateNegativeStatus()
        }
        currentStatus = !watchStatus
    }
    if let trackInfo = message["TrackInfo"] as? [Any] {
        lblTrackTitle.setText(trackInfo[0] as? String)
        lblTrackArtist.setText(trackInfo[1] as? String)
        guard let data = trackInfo[2] as? Data else {return}
        guard let image: UIImage = UIImage(data: data) else { return }
        imgAlbumArt.setImage(image)
    }
  }
}
