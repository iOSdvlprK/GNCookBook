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
    
    fileprivate func RecipeRow(recipe: Recipe) -> some View {
        VStack(alignment: .leading) {
            Image(recipe.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: itemWidth, height: itemHeight)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .clipped()
            Text(recipe.name)
                .lineLimit(1)
                .font(.system(size: 15, weight: .semibold))
        }
    }
    
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
                    ForEach(0...2, id: \.self) { index in
                        RecipeRow(recipe: Recipe.mockRecipes[index])
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
