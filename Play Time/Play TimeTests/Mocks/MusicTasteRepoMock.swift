//
//  MusicTasteRepoMock.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import PTFramework

public class MusicTasteRepoMock: MusicTasteRepoType {
    required public init() { }
    public func storeTaste(taste: [String], completion: @escaping (Result<Bool, Error>) -> Void) {
        if taste == ["rock", "pop"] {
            completion(.success(true))
        }
    }
    public func getTaste(completion: @escaping (Result<[String], Error>) -> Void) {
        completion(.success(["rock", "pop"]))
    }
}
