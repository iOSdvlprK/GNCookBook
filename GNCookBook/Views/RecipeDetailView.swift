//
//  RecipeDetailView.swift
//  GNCookBook
//
//  Created by joe on 2/24/26.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            Image(recipe.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 250)
                .clipped()
            HStack {
                Text(recipe.name)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
                Image(systemName: "clock.fill")
                    .font(.system(size: 15))
                Text("\(recipe.time) mins")
                    .font(.system(size: 15))
            }
            .padding(.top)
            .padding(.horizontal)
            Text(recipe.instructions)
                .font(.system(size: 15))
                .padding(.top, 10)
                .padding(.horizontal)
            Spacer()
        }
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe.mockRecipes[0])
}
