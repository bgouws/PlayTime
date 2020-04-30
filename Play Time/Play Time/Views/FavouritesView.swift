//
//  FavouritesView.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/04/26.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import UIKit

class FavouritesView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnClear: UIButton!
    var favouritesViewModel = FavouritesViewModel()
    var favTracks: [FavTrack] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Favourites"
    }
    @IBAction func btnClearTapped(_ sender: Any) {
        self.favouritesViewModel.clearFavourites()
        tableView.reloadData()
    }
    private func showAlert(title: String, desc: String) {
        let alertController = UIAlertController(title: title, message:
            desc, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    private func prepareView() {
        tableView.delegate = self
        tableView.dataSource = self
        btnClear.defaultButton()
        self.favouritesViewModel.view = self
        self.favouritesViewModel.repo = FavouritesRepo()
        self.favouritesViewModel.getFavourites()
    }
}
extension FavouritesView: FavouritesViewType {
    func loadCurrentTrack(currentTrack: FavTrack) { }
    func loadNextTrack(nextTrack: FavTrack) { }
    func displayDuplicateError(error: String) { }
    func removedSingleItem(isRemoved: Bool) {
        if isRemoved {
            self.favouritesViewModel.getFavourites()
            showAlert(title: "Track Remvoed", desc: "Track has been removed from favourites.")
        } else {
            showAlert(title: "Error", desc: "Unable to remove item.")
        }
    }
    func saveNewFavourite(saved: Bool) {
    }
    func displayCoreDataError(error: Error) {
        showAlert(title: "Error", desc: error.localizedDescription)
    }
    func displayFavCleared(listCleared: Bool) {
        if listCleared == true {
            self.favouritesViewModel.getFavourites()
        } else {
            showAlert(title: "Error", desc: "Unable to clear list.")
        }
    }
    func getFavouriteList(list: [FavTrack]) {
        self.favTracks = list
        tableView.reloadData()
    }
}
extension FavouritesView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favTracks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favTrack = favTracks[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell") as? FavouriteCell else {
            return FavouriteCell()
        }
        cell.setFavCell(favTrack: favTrack)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favTracks.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            self.favouritesViewModel.deleteSingleEnity(index: indexPath.row)
        }
    }
}
