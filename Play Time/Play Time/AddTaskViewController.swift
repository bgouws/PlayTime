//
//  AddTaskViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/19.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var txtTaskTitle: UITextField!
    @IBOutlet weak var txtDuration: UITextField!
    @IBOutlet weak var btnAddTask: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTaskTitle.customTextBox()
        txtDuration.customTextBox()
        btnAddTask.customButton()
        btnCancel.customButton()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.performSegue(withIdentifier: "listView", sender: self)
    }
    @IBAction func btnAddTask(_ sender: Any) {
    }
}
