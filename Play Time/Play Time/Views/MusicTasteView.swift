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
    var userSelection: [String: Bool] = ["Rock": false, "Pop": false, "Indie": false,
                                         "Hip Hop": false, "Country": false, "Jazz": false,
                                         "Pop Rock": false, "Disco": false, "Classic": false,
                                         "Punk": false, "Alt": false, "Blues": false,
                                         "House": false, "Grunge": false, "Techno": false]
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
        userSelection["Rock"] = switchButton(status: userSelection["Rock"]!, button: sender)
    }
    @IBAction func btnPopTapped(_ sender: UIButton) {
        userSelection["Pop"] = switchButton(status: userSelection["Pop"]!, button: sender)
    }
    @IBAction func btnIndieTapped(_ sender: UIButton) {
        userSelection["Indie"] = switchButton(status: userSelection["Indie"]!, button: sender)
    }
    @IBAction func btnHipHopTapped(_ sender: UIButton) {
        userSelection["Hip Hop"] = switchButton(status: userSelection["Hip Hop"]!, button: sender)
    }
    @IBAction func btnCountryTapped(_ sender: UIButton) {
        userSelection["Country"] = switchButton(status: userSelection["Country"]!, button: sender)
    }
    @IBAction func btnJazzTapped(_ sender: UIButton) {
        userSelection["Jazz"] = switchButton(status: userSelection["Jazz"]!, button: sender)
    }
    @IBAction func btnPopRockTapped(_ sender: UIButton) {
        userSelection["Pop Rock"] = switchButton(status: userSelection["Pop Rock"]!, button: sender)
    }
    @IBAction func btnDiscoTapped(_ sender: UIButton) {
        userSelection["Disco"] = switchButton(status: userSelection["Disco"]!, button: sender)
    }
    @IBAction func btnClassicTapped(_ sender: UIButton) {
        userSelection["Classic"] = switchButton(status: userSelection["Classic"]!, button: sender)
    }
    @IBAction func btnPunkTapped(_ sender: UIButton) {
        userSelection["Punk"] = switchButton(status: userSelection["Punk"]!, button: sender)
    }
    @IBAction func btnAltTapped(_ sender: UIButton) {
        userSelection["Alt"] = switchButton(status: userSelection["Alt"]!, button: sender)
    }
    @IBAction func btnBluesTapped(_ sender: UIButton) {
        userSelection["Blues"] = switchButton(status: userSelection["Blues"]!, button: sender)
    }
    @IBAction func btnHouseTapped(_ sender: UIButton) {
        userSelection["House"] = switchButton(status: userSelection["House"]!, button: sender)
    }
    @IBAction func btnGrungeTapped(_ sender: UIButton) {
        userSelection["Grunge"] = switchButton(status: userSelection["Grunge"]!, button: sender)
    }
    @IBAction func btnTechnoTapped(_ sender: UIButton) {
        userSelection["Techno"] = switchButton(status: userSelection["Techno"]!, button: sender)
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
    func musicTasteSaved(didSaveData: Bool) {
        self.performSegue(withIdentifier: "ToListView", sender: self)
    }
    func displayError(error: Error) {
        showAlert(title: "Error", desc: error.localizedDescription)
    }
}
