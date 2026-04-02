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
            AsyncImage(url: URL(string: recipe.image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: itemWidth, height: itemHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .clipped()
            } placeholder: {
                VStack {
                    ProgressView()
                }
                .frame(width: itemWidth, height: itemHeight)
            }

            Text(recipe.name)
                .lineLimit(1)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.black)
        }
    }
    
    let spacing: CGFloat = 10
    let padding: CGFloat = 10
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
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
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.recipes) { recipe in
                            RecipeRow(recipe: recipe)
                        }
                    }
                    .padding(padding)
                }
                Spacer()
                Button(action: {
                    viewModel.showAddRecipeView = true
                }, label: {
                    Text("Add Recipe")
                })
                .buttonStyle(PrimaryButtonStyle())
                .padding(.horizontal)
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
                    if viewModel.signOut() {
                        sessionManager.sessionState = .loggedOut
                    }
                }
                Button("Cancel", role: .cancel) {
                }
            }
        }
        .task {
            await viewModel.fetchRecipes()
        }
        .sheet(isPresented: $viewModel.showAddRecipeView) {
            AddRecipeView()
        }
    }
}

#Preview {
    HomeView()
        .environment(SessionManager())
}
