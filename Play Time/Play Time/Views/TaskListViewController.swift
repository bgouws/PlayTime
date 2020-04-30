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
    var finalMusicTaste = ""
    var useFavourites: Bool = false
    var navigatingToCurrentTask = false
    @IBOutlet weak var actIn: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favSwitch: UISwitch!
    @IBOutlet weak var btnFavourites: UIButton!
    @IBOutlet weak var btnAddSingleTask: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    let myProfileAnalytics = ProfileAnalytics()
    let myTaskListViewAnalytics = TaskListViewAnalytics()
    let musicTasteViewModel = MusicTasteViewModel()
    let taskManipulationViewModel = TaskManipulationViewModel()
    var list: [Task] = []
    let myTaskViewModel = TaskListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        myTaskViewModel.view = self
        myTaskViewModel.repo = TaskListRepo()
        musicTasteViewModel.view = self
        musicTasteViewModel.repo = MusicTasteRepo()
        taskManipulationViewModel.view = self
        taskManipulationViewModel.repo = TaskManipulationRepo()
        myTaskViewModel.getListOfTasks()
        showLoadingIndicator()
        let profileViewModel = ProfileViewModel()
        profileViewModel.setdata { (_, _, _, profileImage) in
            self.btnProfile.setImage(profileImage, for: .normal)
        }
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
    @IBAction func favSwitchTapped(_ sender: UISwitch) {
        if sender.isOn {
            useFavourites = true
        } else {
            useFavourites = false
        }
    }
    @IBAction func btnFavouritesTapped(_ sender: Any) {
        navigatingToCurrentTask = false
        showLoadingIndicator()
        self.performSegue(withIdentifier: "ToFavouritesView", sender: self)
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
            taskManipulationViewModel.removeTask(newList: list)
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
        showLoadingIndicator()
        myTaskListViewAnalytics.taskSelected()
        navigatingToCurrentTask = true
        finalHour = list[indexPath.row].taskHour
        finalMinute = list[indexPath.row].taskMinute
        finalSecond = list[indexPath.row].taskSecond
        finalTitle = list[indexPath.row].taskTitle
        if useFavourites {
            self.performSegue(withIdentifier: "ActiveTaskView", sender: self)
        } else {
            useFavourites = false
            musicTasteViewModel.getMusicTaste()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if navigatingToCurrentTask {
            let currentTaskView = segue.destination as? CurrentTaskViewController
            if let currentTaskView = currentTaskView {
                currentTaskView.taskHour = finalHour
                currentTaskView.taskMinute = finalMinute
                currentTaskView.taskSecond = finalSecond
                currentTaskView.taskTitle = finalTitle
                currentTaskView.genre = finalMusicTaste
                currentTaskView.customPlayList = useFavourites
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
extension TaskListViewController: MusicTasteViewType {
    func musicTasteSaved(didSaveData: Bool) { }
    func dataReady(genre: String) {
        self.hideLoadingIndicator()
        finalMusicTaste = genre
        self.performSegue(withIdentifier: "ActiveTaskView", sender: self)
    }
}
extension TaskListViewController: TaskManipulationViewType {
    func displayManipulationError(error: Error) {
        showAlert(title: "Error", desc: error.localizedDescription)
    }
    func taskAdded(didWriteData: Bool) { }
    func taskRemoved(isSuccessful: Bool) {
        if isSuccessful {
            showAlert(title: "Task Removed", desc: "Task was removed successfully")
        } else {
            showAlert(title: "Error", desc: "Something went wrong")
        }
    }
}
