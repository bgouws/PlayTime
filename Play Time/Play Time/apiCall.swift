//
//  apiCall.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/20.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
// swiftlint:disable all
enum tracksError:Error {
    case noData
}
struct TrackRequest {
    let resourceURL: URL
    //let aPI_KEY = "//itunes.apple.com/search"
    init(trackTitle: String, trackArtist: String) {
        let apiQuery = "https://itunes.apple.com/search/media=music&entity=song&term=\(trackTitle)+\(trackArtist)"
        guard let resourceURL = URL(string: apiQuery) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getData(completion: @escaping(Result<[TrackDetails], tracksError>) -> Void)  {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let tracksResponse = try decoder.decode(Tracks.self, from: jsonData)
                let actualData = tracksResponse.results
                (completion(.success(actualData)))
            } catch {
                completion(.failure(.noData))
            }
        }
        dataTask.resume()
    }
    // swiftlint:enable all
}
