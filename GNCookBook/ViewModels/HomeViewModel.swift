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
            recipes = recipesResult.documents.compactMap { Recipe(snapshot: $0) }
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

