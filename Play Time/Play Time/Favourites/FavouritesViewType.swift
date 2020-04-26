//
//  FavouritesViewType.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/04/26.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation

public protocol FavouritesViewType: class {
    func saveNewFavourite(saved: Bool)
    func getFavouriteList(list: [FavTrack])
    func displayCoreDataError(error: Error)
    func displayFavCleared(listCleared: Bool)
    func removedSingleItem(isRemoved: Bool)
}
