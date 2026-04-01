//
//  HomeViewModel.swift
//  GNCookBook
//
//  Created by joe on 2/21/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class HomeViewModel {
    var showSignOutAlert = false
    var showAddRecipeView = false
    var recipes: [Recipe] = []
    
    func fetchRecipes() async {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("DEBUG: Fetch failed - User not authenticated.")
            return
        }
        do {
            let recipesResult = try await Firestore.firestore().collection("recipes").whereField("userId", isEqualTo: userId).getDocuments()
            for recipeDocument in recipesResult.documents {
                let data = recipeDocument.data()
                guard let imageLocation = data["image"] as? String else {
                    continue
                }
                guard let instructions = data["instructions"] as? String else {
                    continue
                }
                guard let name = data["name"] as? String else {
                    continue
                }
                guard let time = data["time"] as? Int else {
                    continue
                }
                guard let userId = data["userId"] as? String else {
                    continue
                }
                let id = recipeDocument.documentID
                let recipe = Recipe(id: id, name: name, image: imageLocation, instructions: instructions, time: time, userId: userId)
                recipes.append(recipe)
            }
        } catch {
            print("DEBUG: Failed to fetch recipes: \(error.localizedDescription)")
        }
    }
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}

