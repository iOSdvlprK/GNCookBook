//
//  GNCookBookApp.swift
//  GNCookBook
//
//  Created by joe on 2/11/26.
//

import SwiftUI

@main
struct GNCookBookApp: App {
    @State private var sessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            switch sessionManager.sessionState {
            case .loggedIn:
                HomeView()
                    .environment(sessionManager)
            case .loggedOut:
                LoginView()
                    .environment(sessionManager)
            }
        }
    }
}
