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
    var navigatingToCurrentTask = false
    @IBOutlet weak var actIn: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddSingleTask: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    let myProfileAnalytics = ProfileAnalytics()
    let myTaskListViewAnalytics = TaskListViewAnalytics()
    var list: [Task] = []
    let myTaskViewModel = TaskListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        myTaskViewModel.view = self
        myTaskViewModel.repo = TaskListRepo()
        myTaskViewModel.getListOfTasks()
        showLoadingIndicator()
    }
    private func prepareView() {
        btnProfile.profileButton()
        btnAddSingleTask.defaultButton()
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func showLoadingIndicator() {
        actIn.startAnimating()
        actIn.isHidden = false
    }
    private func hideLoadingIndicator() {
        actIn.stopAnimating()
        actIn.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        myTaskViewModel.getListOfTasks()
        tableView.reloadData()
        self.title = "Task List"
    }
    // MARK: Button IBActions
    @IBAction func btnLogout(_ sender: Any) {
        let accManagement = AccountManagementViewModel()
        accManagement.accountManagementView = self
        accManagement.accountManagementRepo = AccountManagementModel()
        navigatingToCurrentTask = false
        showLoadingIndicator()
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive,
                                                handler: {(_) in accManagement.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func btnAddSingleTask(_ sender: Any) {
        navigatingToCurrentTask = false
        self.performSegue(withIdentifier: "ToCreateTask", sender: self)
    }
    @IBAction func btnProfileTapped(_ sender: Any) {
        navigatingToCurrentTask = false
        myProfileAnalytics.profileTapped()
        self.performSegue(withIdentifier: "ToProfileView", sender: self)
    }
    private func showAlert(title: String, desc: String) {
        let alertController = UIAlertController(title: title, message:
            desc, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}
extension TaskListViewController: AccountManagementViewType {
    func readyForNavigation() {
        hideLoadingIndicator()
    }
    func navigate() {
        self.performSegue(withIdentifier: "ToLogout", sender: self)
    }
    func displayError(error: String) {
        showAlert(title: "Error", desc: error)
    }
}
extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = list[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as? TableViewCell else {
            showAlert(title: "Error", desc: "An error has occured")
            return TableViewCell()
        }
        cell.setTask(task: task)
        cell.imgBackground.image = UIImage(named: "cellBlackAndWhite")
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TableViewCell else {
            showAlert(title: "Error", desc: "An error has occured")
            return
        }
        cell.imgBackground.image = UIImage(named: "cellColor")
        myTaskListViewAnalytics.taskSelected()
        navigatingToCurrentTask = true
        finalHour = list[indexPath.row].taskHour
        finalMinute = list[indexPath.row].taskMinute
        finalSecond = list[indexPath.row].taskSecond
        finalTitle = list[indexPath.row].taskTitle
        self.performSegue(withIdentifier: "ActiveTaskView", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if navigatingToCurrentTask {
            let currentTaskView = segue.destination as? CurrentTaskViewController
            if let currentTaskView = currentTaskView {
                currentTaskView.taskHour = finalHour
                currentTaskView.taskMinute = finalMinute
                currentTaskView.taskSecond = finalSecond
                currentTaskView.taskTitle = finalTitle
            } else {
                showAlert(title: "Error", desc: "An error has occured")
            }
        }
    }
}
extension TaskListViewController: TaskListViewType {
    func displayError(error: Error) {
        print(error.localizedDescription)
    }
    func dataReady() {
        hideLoadingIndicator()
    }
    func loadData(listOfTasks: [Task]) {
        self.list = listOfTasks
        tableView.reloadData()
    }
}
