//
//  File.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/20.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation

struct Tracks: Decodable {
    var results: [TrackDetails]
}

struct TrackDetails: Decodable {
    var artistName: String
    var trackName: String
    var artworkUrl100: String
    var collectionName: String
}
