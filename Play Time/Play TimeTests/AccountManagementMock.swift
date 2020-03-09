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
    var successfulLogout = false
    var flag = false
    convenience init() {
        self.init(false)
    }
    init(_ successfulLogout: Bool) {
        self.successfulLogout = successfulLogout
    }
}
extension MockSignUp: LoginProtocol {
    func ptSignIn(email: String, password: String, completion: @escaping (Bool, Any?) -> Void) {
        let mockSignInResponse = "User Successfully Signed In"
        let myPTValidation = PTValidation()
        let result = myPTValidation.ptValidationCheckSignIn(email: email, password: password)
        if result {
            completion(true, mockSignInResponse)
        } else {
            completion(false, nil)
        }
    }
    func ptSignUp(email: String, password: String, conPassword: String,
                  completion: @escaping (Bool, _ String: Any?) -> Void) {
        let mockSignUpResponseSuccess = "User created"
        let myPTValidation = PTValidation()
        let result = myPTValidation.ptValidationCheckSignUp(email: email, password: password, conPassword: conPassword)
        if result {
            completion(true, mockSignUpResponseSuccess)
        } else {
            completion(false, nil)
        }
    }
    func ptSignOut() -> Bool {
        if successfulLogout {
            flag = true
        } else {
            flag = false
        }
        return flag
    }
}
