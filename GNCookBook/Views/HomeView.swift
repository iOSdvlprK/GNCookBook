//
//  HomeView.swift
//  GNCookBook
//
//  Created by joe on 2/11/26.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @Environment(SessionManager.self) private var sessionManager
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Cooking Book App!")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.showSignOutAlert = true
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    })
                }
            }
            .alert("Are you sure you would like to sign out?", isPresented: $viewModel.showSignOutAlert) {
                Button("Sign Out", role: .destructive) {
                    sessionManager.sessionState = .loggedOut
                }
                Button("Cancel", role: .cancel) {
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(SessionManager())
}
