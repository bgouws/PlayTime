//
//  AddTaskView.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/03/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import PTFramework
import MapKit
import CoreLocation

class AddTaskView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var btnCreateTask: UIButton!
    @IBOutlet weak var txtTaskTitle: UITextField!
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    let hours = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10",
                "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21",
                "22", "23", "24"]
    let minutes = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09",
                  "10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
                  "20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
                  "30", "31", "32", "33", "34", "35", "36", "37", "38", "39",
                  "40", "41", "42", "43", "44", "45", "46", "47", "48", "49",
                  "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    let seconds = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09",
                   "10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
                   "20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
                   "30", "31", "32", "33", "34", "35", "36", "37", "38", "39",
                   "40", "41", "42", "43", "44", "45", "46", "47", "48", "49",
                   "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    let numberPickerColumns = 6
    var hourSelected = "00"
    var minuteSelected = "00"
    var secondSelected = "00"
    let manager = CLLocationManager()
    var userLocation: String = "Default"
    let myAddNewTaskAnalytics = AddNewTaskAnalytics()
    let myTaskManipulationViewModel = TaskManipulationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLoadingIndicators()
        prepareView()
        setupLocationData()
        self.myTaskManipulationViewModel.view = self
        self.myTaskManipulationViewModel.repo = TaskManipulationRepo()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Add Task"
    }
    private func prepareView() {
        pickerView.delegate = self
        txtTaskTitle.customTextBox()
        btnCreateTask.customButton()
        txtTaskTitle.delegate = self
    }
    private func showLoadingIndicators() {
        actIndicator.startAnimating()
        actIndicator.isHidden = true
    }
    private func hideLoadingIndicators() {
        actIndicator.stopAnimating()
        actIndicator.isHidden = true
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberPickerColumns
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hours.count
        } else if component == 2 {
            return minutes.count
        } else if component == 4 {
            return seconds.count
        }
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return hours[row]
        case 1:
            return "H"
        case 2:
            return minutes[row]
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
        let title = txtTaskTitle.text ?? "No Title"
        showLoadingIndicators()
        let newTask = Task(taskTitle: title, taskHour: hourSelected, taskMinute: minuteSelected,
                           taskSecond: secondSelected, location: userLocation)
        self.myTaskManipulationViewModel.addNewItem(newTask: newTask)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            hourSelected = hours[row]
        } else if component == 2 {
            minuteSelected = minutes[row]
        } else if component == 4 {
            secondSelected = seconds[row]
        }
        myAddNewTaskAnalytics.pickerTimeSet()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    private func showAlert(error: String) {
        let alertController = UIAlertController(title: "Error", message:
            "\(error)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    private func setupLocationData() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}
extension AddTaskView: TaskManipulationViewType {
    func displayManipulationError(error: Error) {
        showAlert(error: error.localizedDescription)
    }
    func taskRemoved(isSuccessful: Bool) { }
    func taskAdded(didWriteData: Bool) {
        if didWriteData {
            hideLoadingIndicators()
            navigationController?.popViewController(animated: true)
        }
    }
    func displayError(error: Error) {
        showAlert(error: error.localizedDescription)
    }
}
extension AddTaskView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(CLLocation.init(latitude: location.coordinate.latitude,
                                       longitude: location.coordinate.longitude)) { (places, error) in
            if error == nil {
                if let place = places {
                    let data = place.description
                    let array = data.components(separatedBy: ",")
                    self.userLocation = "Location: \(array[1])\(array[2])\(array[3])\(array[4])"
                }
            }
        }
    }
}
