//
//  FavouritesRepoType.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/04/26.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation

public protocol FavouritesRepoType {
    func save(track: FavTrack) -> Result<Bool, Error>
    func getFavourites() -> Result<[FavTrack], Error>
    func deleteAllData() -> Result<Bool, Error>
    func deleteSingleEntity(removeIndex: Int) -> Result<Bool, Error>
}
