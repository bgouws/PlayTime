//
//  AddTaskView.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/03/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import PTFramework

class AddTaskView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    let hour = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10",
                "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
    let minute = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10",
                "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
                "31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
                "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
                "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    let seconds = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10",
                   "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                   "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
                   "31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
                   "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
                   "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    var hourSelected = ""
    var minuteSelected = ""
    var secondSelected = ""
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 6
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hour.count
        } else if component == 2 {
            return minute.count
        } else if component == 4 {
            return seconds.count
        }
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return hour[row]
        case 1:
            return "H"
        case 2:
            return minute[row]
        case 3:
            return "M"
        case 4:
            return seconds[row]
        case 5:
            return "S"
        default:
            return "Error"
        }
    }
    @IBAction func btnCreateTask(_ sender: Any) {
        print("++++++++")
        print("Hour: \(hourSelected) Minute: \(minuteSelected) Second: \(secondSelected)")
        print("++++++++")
        actIndicator.isHidden = false
        let myAddTask = TasksViewModel()
        myAddTask.insertTask(taskTitle: txtTaskTitle.text!, hour: hourSelected, minute: minuteSelected,
                             second: secondSelected) { (success) in
            if success {
                actIndicator.isHidden = true
                myAddNewTaskAnalytics.addNewTask()
            } else {
                actIndicator.isHidden = true
                //call alert
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print("Hour: \(hour[row])")
            hourSelected = hour[row]
        } else if component == 2 {
            print("Minute: \(minute[row])")
            minuteSelected = minute[row]
        } else if component == 4 {
            print("Second: \(seconds[row])")
            secondSelected = seconds[row]
        }
        myAddNewTaskAnalytics.pickerTimeSet()
    }
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var btnCreateTask: UIButton!
    @IBOutlet weak var txtTaskTitle: UITextField!
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    let myAddNewTaskAnalytics = AddNewTaskAnalytics()
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        btnCreateTask.defaultButton()
        txtTaskTitle.customTextBox()
        txtTaskTitle.delegate = self
        actIndicator.isHidden = true
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
