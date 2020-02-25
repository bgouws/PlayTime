//
//  TaskListViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/18.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import Firebase

class TaskListViewController: UIViewController {

    var finalHour = ""
    var finalMinute = ""
    var finalSecond = ""
    var finalTitle = ""
    let move = "SignOutView"
    var flag = false
    //@IBOutlet weak var btnAddTask: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var txtTaskTitle: UITextField!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDuration: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddSingleTask: UIButton!
    //@IBOutlet weak var btnAddNow: UIButton!
    var tasks: [Task] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = createTask()
        tableView.delegate = self
        tableView.dataSource = self
        authenticateUserAndConfigure()
        // Do any additional setup after loading the view.
    }
    func authenticateUserAndConfigure() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "SignOutView", sender: self)
            }
        }
    }
    @IBAction func btnLogout(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive,
                                                handler: {(_) in self.signOut(moveTo: self.move)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    func createTask() -> [Task] { //Read text file here
        //Test
            //Creating textfile test
            let fileName = "Tasks"
            // swiftlint:disable all
            let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                              appropriateFor: nil, create: true)
            // swiftlint:enable all
            let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
            print("File Path: \(fileURL.path)")
            let writeString = "This is the data that I am writing the the text file"
            do {
                //Write to file
                try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("Failed to write to URL ")
                print(error)
            }
            var readString = ""
            do {
                readString = try String(contentsOf: fileURL)
            } catch let error as NSError {
                print("Failed to read file")
                print(error)
            }
            print("Contents of the file: \(readString)")
        //Test
        var tempTask: [Task] = []
        let task1 = Task(title: "Cooking", hour: "01", minute: "00", second: "00")
        let task2 = Task(title: "Cleaning", hour: "00", minute: "30", second: "00")
        let task3 = Task(title: "Working", hour: "02", minute: "30", second: "00")
        let task4 = Task(title: "Gyming", hour: "00", minute: "00", second: "10")
        let task5 = Task(title: "Shopping", hour: "00", minute: "45", second: "45")
        tempTask.append(task1)
        tempTask.append(task2)
        tempTask.append(task3)
        tempTask.append(task4)
        tempTask.append(task5)
        return tempTask
    }
    func insetNewTask() {
        let duration = txtDuration.text?.components(separatedBy: ":")
        finalHour = (duration?[0])!
        finalMinute = (duration?[1])!
        finalSecond = (duration?[2])!
        finalTitle = txtTitle.text!
        let newTask = Task(title: finalTitle, hour: finalHour, minute: finalMinute, second: finalSecond)
        tasks.append(newTask)
        let indexPath = IndexPath(row: tasks.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
        txtTitle.text = ""
        txtDuration.text = ""
        view.endEditing(true)
    }
    @IBAction func btnAddSingleTask(_ sender: Any) {
        insetNewTask()
    }
    func signOut(moveTo: String) {
        do {
            flag = false
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: moveTo, sender: self)
        } catch let error {
            print("Failed to sign out with error: ", error.localizedDescription)
        }
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        // swiftlint:disable all
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TableViewCell
        // swiftlint:enable all
        cell.setTask(task: task)
        return cell
    }
    //To enable delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell number: \(indexPath.row)!")
        flag = true
        finalHour = tasks[indexPath.row].hour
        finalMinute = tasks[indexPath.row].minute
        finalSecond = tasks[indexPath.row].second
        finalTitle = tasks[indexPath.row].title
        self.performSegue(withIdentifier: "ActiveTaskView", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if flag {
            // swiftlint:disable all
            let vc = segue.destination as! CurrentTaskViewController
            // swiftlint:enable all
            vc.fHour = finalHour
            vc.fMinute = finalMinute
            vc.fSecond = finalSecond
            vc.fTitle = finalTitle
        }
    }
}
