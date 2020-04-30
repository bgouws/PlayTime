//
//  MockAPI.swift
//  Play TimeTests
//
//  Created by Brandon Gouws on 2020/04/29.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import PTFramework

public class AccountManagementRepoMock: AccountManagementDataSourceType {
    public func login(email: String, password: String, _ completion: @escaping (String?, Bool) -> Void) {
        let validEmail = self.isValidEmail(email)
        if validEmail {
            completion("Login Successful", true)
        } else {
            completion("Unsuccessful login", false)
        }
    }
    public func signUp(email: String, password: String, _ completion: @escaping (String?, Bool) -> Void) {
        let validEmail = self.isValidEmail(email)
        if validEmail {
            completion("Login Successful", true)
        } else {
            completion("Unsuccessful login", false)
        }
    }
    public func signOut(_ completion: @escaping (String?, Bool) -> Void) {
        completion("Successful Logout", true)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
