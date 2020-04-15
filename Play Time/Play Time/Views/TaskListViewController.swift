//
//  TaskListViewController.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/18.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit
import Firebase
import PTFramework

class TaskListViewController: UIViewController {
    var finalHour = ""
    var finalMinute = ""
    var finalSecond = ""
    var finalTitle = ""
    var flag = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddSingleTask: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    let myProfileAnalytics = ProfileAnalytics()
    let myTaskListViewAnalytics = TaskListViewAnalytics()
    var tasks: [PTTask] = []
    let getTasks = TasksViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Calling Api")
        let myPTPlayMusic = PTPlayMusic()
        myPTPlayMusic.readData()
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        authenticateUserAndConfigure()
        btnProfile.profileButton()
        btnAddSingleTask.customButton()
    }
    func authenticateUserAndConfigure() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "NotLoggedInView", sender: self)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let myData = TasksViewModel()
        let myImage = ProfileViewModel()
        myImage.setdata { (_, _, _, img) in
            self.btnProfile.setImage(img, for: .normal)
        }
        self.title = "Task List"
        myData.getListOfTasks { (listOfTasks) in
            self.tasks = listOfTasks
            print("\(self.tasks[0].title) \(self.tasks[0].minute) \(self.tasks[0].second)")
            self.tableView.reloadData()
        }
    }
    @IBAction func btnAddSingleTask(_ sender: Any) {
        self.performSegue(withIdentifier: "ToCreateTask", sender: self)
    }
    @IBAction func btnLogout(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive,
                                                handler: {(_) in self.signOut(moveTo: "ToLogout")
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
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
    @IBAction func btnProfileTapped(_ sender: Any) {
        flag = false
        myProfileAnalytics.profileTapped()
        self.performSegue(withIdentifier: "ToProfileView", sender: self)
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
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        myTaskListViewAnalytics.taskDeleted()
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell number: \(indexPath.row)!")
        myTaskListViewAnalytics.taskSelected()
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
