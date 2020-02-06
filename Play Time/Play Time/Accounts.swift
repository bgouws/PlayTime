//
//  Accounts.swift
//  Play Time
//
//  Created by Brandon Gouws on 2020/02/05.
//  Copyright © 2020 Brandon Gouws. All rights reserved.
//

import Foundation
import UIKit

class Accounts {
    
    //Variables
    var email = ""
    var password = ""
    
    init (){
    }
    
    func setAccounts(email :String, password :String){
        self.email = email
        self.password = password
    }
    
    func getEmail() -> String {
        return self.email
    }
}
