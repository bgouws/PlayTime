//
//  FavouritesViewModel.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/04/26.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation

public class FavouritesViewModel {
    public weak var view: FavouritesViewType?
    public var repo: FavouritesRepoType?
    public init() { }
    public func saveTrack(track: FavTrack) {
        let result = repo?.save(track: track)
        switch result {
        case .success(let isSuccessful):
            view?.saveNewFavourite(saved: isSuccessful)
        case .failure(let error):
            view?.displayCoreDataError(error: error)
        default:
            print("Unknown Error")
        }
    }
    public func getFavourites() {
        let result = repo?.getFavourites()
        switch result {
        case .success(let listOfFavourites):
            view?.getFavouriteList(list: listOfFavourites)
        case .failure(let error):
            view?.displayCoreDataError(error: error)
        default:
            print("Unknown Error")
        }
    }
    public func clearFavourites() {
        let result = repo?.deleteAllData()
        switch result {
        case .success(let isSuccessful):
            view?.displayFavCleared(listCleared: isSuccessful)
        case .failure(let error):
            view?.displayCoreDataError(error: error)
        default:
            view?.displayFavCleared(listCleared: false)
        }
    }
    public func deleteSingleEnity(index: Int) {
        let result = repo?.deleteSingleEntity(removeIndex: index)
        switch result {
        case .success(let isSuccessful):
            view?.removedSingleItem(isRemoved: isSuccessful)
        case .failure(let error):
            view?.displayCoreDataError(error: error)
        default:
            print("Unknown Error")
        }
    }
}
