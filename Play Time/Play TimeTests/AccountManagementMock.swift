//
//  SignUpMock.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/03/08.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
@testable import PTFramework
@testable import Play_Time

class MockingLoginProtocol: LoginProtocol {
    func ptSignUp(email: String, password: String, conPassword: String, completion: @escaping (Bool, String) -> Void) {
        if email == "brandongouws100@gmail.com" {
            completion(true, "Successful SignUp")
        }
    }
    func ptSignIn(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        print("Happydays")
        completion(true, "Happydays")
    }
    func ptSignOut() -> Bool {
        print("Happydays")
        return true
    }
}
