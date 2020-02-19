//
//  TaskListViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/18.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {

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
    func createTask() -> [Task] {
        var tempTask: [Task] = []
        let task1 = Task(title: "Cooking", hour: "01", minute: "00", second: "00")
        let task2 = Task(title: "Cleaning", hour: "00", minute: "30", second: "00")
        let task3 = Task(title: "Working", hour: "02", minute: "30", second: "00")
        let task4 = Task(title: "Running", hour: "00", minute: "20", second: "00")
        let task5 = Task(title: "Shopping", hour: "00", minute: "45", second: "45")
        tempTask.append(task1)
        tempTask.append(task2)
        tempTask.append(task3)
        tempTask.append(task4)
        tempTask.append(task5)
        return tempTask
    }
    func insetNewTask() {
        let newTask = Task(title: "Cooking", hour: "01", minute: "00", second: "00")
        tasks.append(newTask)
        let indexPath = IndexPath(row: tasks.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
        txtTitle.text = ""
        view.endEditing(true)
    }
    @IBAction func btnAddSingleTask(_ sender: Any) {
        //self.performSegue(withIdentifier: "addTaskView", sender: self)
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
}
