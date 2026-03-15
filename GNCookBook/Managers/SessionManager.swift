//
//  SessionManager.swift
//  GNCookBook
//
//  Created by joe on 2/20/26.
//

import Foundation
import FirebaseAuth
import FirebaseCore

@Observable
class SessionManager {
    var sessionState: SessionState = .loggedOut
    var currentUser: User?
    
    init() {
        FirebaseApp.configure()
        sessionState = Auth.auth().currentUser != nil ? .loggedIn : .loggedOut
    }
}
