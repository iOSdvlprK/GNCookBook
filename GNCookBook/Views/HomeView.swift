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
    
    let spacing: CGFloat = 5
    let padding: CGFloat = 5
    
    var itemWidth: CGFloat {
        guard let screen = UIScreen.current else { return .zero }
        let screenWidth = screen.bounds.width
        return (screenWidth - (spacing * 2) - (padding * 2)) / 3
    }
    var itemHeight: CGFloat {
        return CGFloat(1.5) * itemWidth
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: spacing) {
                    VStack(alignment: .leading) {
                        Image(Recipe.mockRecipes[0].image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: itemWidth, height: itemHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                        Text(Recipe.mockRecipes[0].name)
                            .lineLimit(1)
                            .font(.system(size: 15, weight: .semibold))
                    }
                    VStack(alignment: .leading) {
                        Image(Recipe.mockRecipes[1].image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: itemWidth, height: itemHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                        Text(Recipe.mockRecipes[1].name)
                            .lineLimit(1)
                            .font(.system(size: 15, weight: .semibold))
                    }
                    VStack(alignment: .leading) {
                        Image(Recipe.mockRecipes[2].image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: itemWidth, height: itemHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                        Text(Recipe.mockRecipes[2].name)
                            .lineLimit(1)
                            .font(.system(size: 15, weight: .semibold))
                    }
                }
                .padding(.horizontal, padding)
                Spacer()
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
