//
//  MusicListRepoMock.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import PTFramework

public class MusicListRepoMock: MusicListDataSourceType {
    var genre: String = ""
    var tracks: [TrackDetails] = []
    public required init?(genre: String) {
        self.genre = genre
    }
    public func getListOfTracks(completion: @escaping (Result<[TrackDetails], TracksError>) -> Void) {
        if genre == "Rock" {
            completion(.success(tracks))
        } else {
            completion(.failure(.noData))
        }
    }
}
