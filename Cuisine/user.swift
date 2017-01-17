//
//  user.swift
//  Cuisine
//
//  Created by Lois van Vliet on 16-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    let uid: String
    let email: String
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
