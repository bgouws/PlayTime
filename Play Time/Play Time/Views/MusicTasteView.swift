//
//  MusicTasteViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/16.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import Firebase
import PTFramework
import SkeletonView

class MusicTasteView: UIViewController {
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnRock: UIButton!
    @IBOutlet weak var btnPop: UIButton!
    @IBOutlet weak var btnIndie: UIButton!
    @IBOutlet weak var btnHipHop: UIButton!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnJazz: UIButton!
    @IBOutlet weak var btnPopRock: UIButton!
    @IBOutlet weak var btnDisco: UIButton!
    @IBOutlet weak var btnClassic: UIButton!
    @IBOutlet weak var btnPunk: UIButton!
    @IBOutlet weak var btnAlt: UIButton!
    @IBOutlet weak var btnBlues: UIButton!
    @IBOutlet weak var btnHouse: UIButton!
    @IBOutlet weak var btnGrunge: UIButton!
    @IBOutlet weak var btnTechno: UIButton!
    let myMusicTasteAnalytics = MusicTasteAnalytics()
    let myMusicTasteViewModel = MusicTasteViewModel()
    var list: [String] = []
    var userSelection: [String: Bool] = ["rock": false, "pop": false, "indie": false,
                                         "r&b": false, "country": false, "jazz": false,
                                         "pop+rock": false, "disco": false, "classic": false,
                                         "punk": false, "alternative": false, "blues": false,
                                         "house": false, "grunge": false, "techno": false]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myMusicTasteViewModel.view = self
        self.myMusicTasteViewModel.repo = MusicTasteRepo()
        prepareView()
    }
    @IBAction func btnStart(_ sender: Any) {
        for (genre, selected) in userSelection where selected {
            list.append(genre)
        }
        checkMusicTastelist(musicTasteList: list)
        self.myMusicTasteViewModel.storeTaste(tasteList: list)
    }
    @IBAction func btnRockTapped(_ sender: UIButton) {
        userSelection["rock"] = switchButton(status: userSelection["rock"]!, button: sender)
    }
    @IBAction func btnPopTapped(_ sender: UIButton) {
        userSelection["pop"] = switchButton(status: userSelection["pop"]!, button: sender)
    }
    @IBAction func btnIndieTapped(_ sender: UIButton) {
        userSelection["indie"] = switchButton(status: userSelection["indie"]!, button: sender)
    }
    @IBAction func btnHipHopTapped(_ sender: UIButton) {
        userSelection["r&b"] = switchButton(status: userSelection["r&b"]!, button: sender)
    }
    @IBAction func btnCountryTapped(_ sender: UIButton) {
        userSelection["country"] = switchButton(status: userSelection["country"]!, button: sender)
    }
    @IBAction func btnJazzTapped(_ sender: UIButton) {
        userSelection["jazz"] = switchButton(status: userSelection["jazz"]!, button: sender)
    }
    @IBAction func btnPopRockTapped(_ sender: UIButton) {
        userSelection["pop+rock"] = switchButton(status: userSelection["pop+rock"]!, button: sender)
    }
    @IBAction func btnDiscoTapped(_ sender: UIButton) {
        userSelection["disco"] = switchButton(status: userSelection["disco"]!, button: sender)
    }
    @IBAction func btnClassicTapped(_ sender: UIButton) {
        userSelection["classic"] = switchButton(status: userSelection["classic"]!, button: sender)
    }
    @IBAction func btnPunkTapped(_ sender: UIButton) {
        userSelection["punk"] = switchButton(status: userSelection["punk"]!, button: sender)
    }
    @IBAction func btnAltTapped(_ sender: UIButton) {
        userSelection["alternative"] = switchButton(status: userSelection["alternative"]!, button: sender)
    }
    @IBAction func btnBluesTapped(_ sender: UIButton) {
        userSelection["blues"] = switchButton(status: userSelection["blues"]!, button: sender)
    }
    @IBAction func btnHouseTapped(_ sender: UIButton) {
        userSelection["house"] = switchButton(status: userSelection["house"]!, button: sender)
    }
    @IBAction func btnGrungeTapped(_ sender: UIButton) {
        userSelection["grunge"] = switchButton(status: userSelection["grunge"]!, button: sender)
    }
    @IBAction func btnTechnoTapped(_ sender: UIButton) {
        userSelection["techno"] = switchButton(status: userSelection["techno"]!, button: sender)
    }
    func switchButton(status: Bool, button: UIButton) -> Bool {
        let newStatus = !status
        if newStatus {
            button.backgroundColorChange(status: newStatus)
        } else {
            button.backgroundColor = UIColor.gray
        }
        button.pulsate()
        return newStatus
    }
    private func showAlert(title: String, desc: String) {
        let alertController = UIAlertController(title: "Error", message:
            "\(desc)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    private func checkMusicTastelist(musicTasteList: [String]) {
        if list.isEmpty {
            showAlert(title: "No selected genres", desc: "Please select some genres")
            return
        }
    }
    private func prepareView() {
        btnRock.musicSelectionButtonStyle()
        btnPop.musicSelectionButtonStyle()
        btnIndie.musicSelectionButtonStyle()
        btnHipHop.musicSelectionButtonStyle()
        btnCountry.musicSelectionButtonStyle()
        btnJazz.musicSelectionButtonStyle()
        btnPopRock.musicSelectionButtonStyle()
        btnDisco.musicSelectionButtonStyle()
        btnClassic.musicSelectionButtonStyle()
        btnPunk.musicSelectionButtonStyle()
        btnAlt.musicSelectionButtonStyle()
        btnBlues.musicSelectionButtonStyle()
        btnHouse.musicSelectionButtonStyle()
        btnGrunge.musicSelectionButtonStyle()
        btnTechno.musicSelectionButtonStyle()
        btnStart.defaultButton()
    }
}
extension MusicTasteView: MusicTasteViewType {
    func dataReady(genre: String) { }
    func musicTasteSaved(didSaveData: Bool) {
        self.performSegue(withIdentifier: "ToListView", sender: self)
    }
    func displayError(error: Error) {
        showAlert(title: "Error", desc: error.localizedDescription)
    }
}
