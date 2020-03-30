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

class MusicTasteViewController: UIViewController {

    var list: [String] = []
    var checker = true
    var count = 0
    let myPTTasteSelection = PTTasteSelection()
    // MARK: Components
    @IBOutlet weak var btnRock: UIButton!
    @IBOutlet weak var btnPop: UIButton!
    @IBOutlet weak var btnIndie: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnHipHop: UIButton!
    @IBOutlet weak var btnJazz: UIButton!
    let myMusicTasteAnalytics = MusicTasteAnalytics()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnStart.defaultButton()
        setButton()
    }
    // MARK: Button Action Functions
    @IBAction func btnRock(_ sender: UIButton) {
        sender.colorChange(checker: checker)
        changeCheck()
        myMusicTasteAnalytics.musicTasteRock()
        if myPTTasteSelection.ptCheckList(value: "Rock", taste: list) && btnRock.backgroundColor != UIColor.lightGray {
            return
        } else if myPTTasteSelection.ptCheckList(value: "Rock", taste: list) &&
                  btnRock.backgroundColor == UIColor.lightGray {
            list.remove(at: getIndex(value: "Rock"))
        } else {
            list.append("Rock")
        }
    }
    @IBAction func btnPop(_ sender: UIButton) {
        sender.colorChange(checker: checker)
        changeCheck()
        myMusicTasteAnalytics.musicTastePop()
        if myPTTasteSelection.ptCheckList(value: "Pop", taste: list) && btnPop.backgroundColor != UIColor.lightGray {
            return
        } else if myPTTasteSelection.ptCheckList(value: "Pop", taste: list) &&
                  btnPop.backgroundColor == UIColor.lightGray {
            list.remove(at: getIndex(value: "Pop"))
        } else {
            list.append("Pop")
        }
    }
    @IBAction func btnIndie(_ sender: UIButton) {
        sender.colorChange(checker: checker)
        changeCheck()
        myMusicTasteAnalytics.musicTasteIndie()
        if myPTTasteSelection.ptCheckList(value: "Indie", taste: list)
            && btnIndie.backgroundColor != UIColor.lightGray {
            return
        } else if myPTTasteSelection.ptCheckList(value: "Indie", taste: list) &&
                  btnIndie.backgroundColor == UIColor.lightGray {
            list.remove(at: getIndex(value: "Indie"))
        } else {
            list.append("Indie")
        }
    }
    @IBAction func btnHipHop(_ sender: UIButton) {
        sender.colorChange(checker: checker)
        changeCheck()
        myMusicTasteAnalytics.musicTasteHipHop()
        if myPTTasteSelection.ptCheckList(value: "HipHop", taste: list) &&
           btnHipHop.backgroundColor != UIColor.lightGray {
            return
        } else if myPTTasteSelection.ptCheckList(value: "HipHop", taste: list) &&
                  btnHipHop.backgroundColor == UIColor.lightGray {
            list.remove(at: getIndex(value: "HipHop"))
        } else {
            list.append("HipHop")
        }
    }
    @IBAction func btnCountry(_ sender: UIButton) {
        sender.colorChange(checker: checker)
        changeCheck()
        myMusicTasteAnalytics.musicTasteCountry()
        if myPTTasteSelection.ptCheckList(value: "Country", taste: list) &&
           btnCountry.backgroundColor != UIColor.lightGray {
            return
        } else if myPTTasteSelection.ptCheckList(value: "Country", taste: list) &&
                  btnCountry.backgroundColor == UIColor.lightGray {
            list.remove(at: getIndex(value: "Country"))
        } else {
            list.append("Country")
        }
    }
    @IBAction func btnJazz(_ sender: UIButton) {
        sender.colorChange(checker: checker)
        changeCheck()
        myMusicTasteAnalytics.musicTasteJazz()
        if myPTTasteSelection.ptCheckList(value: "Jazz", taste: list) && btnJazz.backgroundColor != UIColor.lightGray {
            return
        } else if myPTTasteSelection.ptCheckList(value: "Jazz", taste: list) &&
                  btnJazz.backgroundColor == UIColor.lightGray {
            list.remove(at: getIndex(value: "Jazz"))
        } else {
            list.append("Jazz")
        }
    }
    func changeCheck() {
        if checker == true {
            checker = false
        } else {
            checker = true
        }
    }
    func setButton() {
        btnRock.backgroundColor = UIColor.lightGray
        btnPop.backgroundColor = UIColor.lightGray
        btnIndie.backgroundColor = UIColor.lightGray
        btnHipHop.backgroundColor = UIColor.lightGray
        btnCountry.backgroundColor = UIColor.lightGray
        btnJazz.backgroundColor = UIColor.lightGray
    }
    @IBAction func btnStart(_ sender: Any) {
        //Calling MusicSelection ViewModel
        myPTTasteSelection.ptSaveMusicTaste(taste: list)
        myMusicTasteAnalytics.musicTasteStored()
        self.performSegue(withIdentifier: "ToListView", sender: self)
    }
    func getIndex(value: String) -> Int {
        let index = list.firstIndex(of: value)
        print(index!)
        return index!
    }
}
