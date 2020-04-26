//
//  FavouritesRepo.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/04/26.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class FavouritesRepo: FavouritesRepoType {
    public init() { }
    public func save(track: FavTrack) -> Result<Bool, Error> {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "Favourites",
                                                                     in: context) else { return .success(false) }
            let newValue = NSManagedObject(entity: entityDescription, insertInto: context)
            newValue.setValue(track.trackTitle, forKey: "tracktitle")
            newValue.setValue(track.artistName, forKey: "trackartist")
            newValue.setValue(track.artworkUrl100, forKey: "albumart")
            newValue.setValue(track.artworkUrl100, forKey: "previewurl")
            do {
                try context.save()
            } catch let error as NSError {
                return .failure(error)
            }
        }
        return .success(true)
    }
    public func getFavourites() -> Result<[FavTrack], Error> {
        var favTracks: [FavTrack] = []
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Favourites>(entityName: "Favourites")
            do {
                let results = try context.fetch(fetchRequest)
                for result in results {
                    let favTrack = FavTrack(artistName: result.trackartist!,
                                            trackTitle: result.tracktitle!,
                                            artworkUrl100: result.albumart!,
                                            previewUrl: result.previewurl!)
                    favTracks.append(favTrack)
                }
            } catch let error as NSError {
                return .failure(error)
            }
        }
        return .success(favTracks)
    }
    public func deleteAllData() -> Result<Bool, Error> {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Favourites>(entityName: "Favourites")
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(fetchRequest)
                for attribute in results {
                    context.delete(attribute)
                }
                try context.save()
            } catch let error as NSError {
                return .failure(error)
            }
        }
        return .success(true)
    }
    public func deleteSingleEntity(removeIndex: Int) -> Result<Bool, Error> {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Favourites>(entityName: "Favourites")
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(fetchRequest)
                context.delete(results[removeIndex])
                try context.save()
            } catch let error as NSError {
                return .failure(error)
            }
        }
        return .success(true)
    }
}
