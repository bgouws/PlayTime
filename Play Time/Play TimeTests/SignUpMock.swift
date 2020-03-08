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

class MockSignUp {

}

extension MockSignUp: LoginProtocol {
    func ptSignUp(email: String, password: String, conPassword: String, completion: @escaping (Bool, _ String: Any?) -> ()) {
        let mockSignUpResponseSuccess = "User created"
        let myPTValidation = PTValidation()
        let result = myPTValidation.ptValidationCheckSignUp(email: email, password: password, conPassword: conPassword)
        if result {
            completion(true, mockSignUpResponseSuccess)
        } else {
            completion(false, nil)
        }
    }
}
