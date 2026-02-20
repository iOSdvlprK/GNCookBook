//
//  HomeView.swift
//  GNCookBook
//
//  Created by joe on 2/11/26.
//

import SwiftUI

struct HomeView: View {
    @Environment(SessionManager.self) private var sessionManager
    
    var body: some View {
        VStack {
            Text("Cooking Book App!")
        }
    }
}

#Preview {
    HomeView()
        .environment(SessionManager())
}
