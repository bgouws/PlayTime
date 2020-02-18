//
//  MusicTasteViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/16.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import Firebase

class MusicTasteViewController: UIViewController {

    var list = [""]
    var checker = true
    var count = 0
    // MARK: Components
    @IBOutlet weak var btnRock: UIButton!
    @IBOutlet weak var btnPop: UIButton!
    @IBOutlet weak var btnIndie: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnHipHop: UIButton!
    @IBOutlet weak var btnJazz: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnStart.customButton()
        setButton()
    }
    // MARK: Button Action Functions
    @IBAction func btnRock(_ sender: UIButton) {
        sender.colorChange(checker: checker)
        changeCheck()
        if checkList(value: "Rock") && btnRock.backgroundColor != UIColor.lightGray {
            return
        } else if checkList(value: "Rock") && btnRock.backgroundColor == UIColor.lightGray {
            list.remove(at: getIndex(value: "Rock"))
        } else {
            list.append("Rock")
        }
    }
    @IBAction func btnPop(_ sender: UIButton) {
        sender.colorChange(checker: checker)
        changeCheck()
        if checkList(value: "Pop") && btnPop.backgroundColor != UIColor.lightGray {
            return
        } else if checkList(value: "Pop") && btnPop.backgroundColor == UIColor.lightGray {
            list.remove(at: getIndex(value: "Pop"))
        } else {
            list.append("Pop")
        }
    }
    @IBAction func btnIndie(_ sender: UIButton) {
        sender.colorChange(checker: checker)
        changeCheck()
        if checkList(value: "Indie") && btnIndie.backgroundColor != UIColor.lightGray {
            return
        } else if checkList(value: "Indie") && btnIndie.backgroundColor == UIColor.lightGray {
            list.remove(at: getIndex(value: "Indie"))
        } else {
            list.append("Indie")
        }
    }
    @IBAction func btnHipHop(_ sender: UIButton) {
        sender.colorChange(checker: checker)
        changeCheck()
        if checkList(value: "HipHop") && btnHipHop.backgroundColor != UIColor.lightGray {
            return
        } else if checkList(value: "HipHop") && btnHipHop.backgroundColor == UIColor.lightGray {
            list.remove(at: getIndex(value: "HipHop"))
        } else {
            list.append("HipHop")
        }
    }
    @IBAction func btnCountry(_ sender: UIButton) {
        sender.colorChange(checker: checker)
        changeCheck()
        if checkList(value: "Country") && btnCountry.backgroundColor != UIColor.lightGray {
            return
        } else if checkList(value: "Country") && btnCountry.backgroundColor == UIColor.lightGray {
            list.remove(at: getIndex(value: "Country"))
        } else {
            list.append("Country")
        }
    }
    @IBAction func btnJazz(_ sender: UIButton) {
        sender.colorChange(checker: checker)
        changeCheck()
        if checkList(value: "Jazz") && btnJazz.backgroundColor != UIColor.lightGray {
            return
        } else if checkList(value: "Jazz") && btnJazz.backgroundColor == UIColor.lightGray {
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
        print(list)
        let ref = Database.database().reference()
        let user = Auth.auth().currentUser?.uid
        ref.child("users").child(user!).setValue(["Music Taste": list])
    }
    func checkList(value: String) -> Bool {
        for genre in list where genre == value {
            return true
        }
          return false
    }
    func getIndex(value: String) -> Int {
        let index = list.firstIndex(of: value)
        print(index!)
        return index!
    }
}
