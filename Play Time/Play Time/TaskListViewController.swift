//
//  TaskListViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/18.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {

    var finalHour = ""
    var finalMinute = ""
    var finalSecond = ""
    var finalTitle = ""
    //@IBOutlet weak var btnAddTask: UIButton!
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
        // Do any additional setup after loading the view.
    }
    func createTask() -> [Task] { //Read text file here
        var tempTask: [Task] = []
        let task1 = Task(title: "Cooking", hour: "01", minute: "00", second: "00")
        let task2 = Task(title: "Cleaning", hour: "00", minute: "30", second: "00")
        let task3 = Task(title: "Working", hour: "02", minute: "30", second: "00")
        let task4 = Task(title: "Running", hour: "00", minute: "20", second: "00")
        let task5 = Task(title: "Shopping", hour: "00", minute: "45", second: "45")
        let task6 = Task(title: "Test", hour: "00", minute: "00", second: "30")
        tempTask.append(task1)
        tempTask.append(task2)
        tempTask.append(task3)
        tempTask.append(task4)
        tempTask.append(task5)
        tempTask.append(task6)
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
        finalHour = tasks[indexPath.row].hour
        finalMinute = tasks[indexPath.row].minute
        finalSecond = tasks[indexPath.row].second
        finalTitle = tasks[indexPath.row].title
        self.performSegue(withIdentifier: "ActiveTaskView", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // swiftlint:disable all
        let vc = segue.destination as! CurrentTaskViewController
        // swiftlint:enable all
        vc.fHour = finalHour
        vc.fMinute = finalMinute
        vc.fSecond = finalSecond
        vc.fTitle = finalTitle
    }
}
