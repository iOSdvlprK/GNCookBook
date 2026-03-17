//
//  HomeViewModel.swift
//  GNCookBook
//
//  Created by joe on 2/21/26.
//

import Foundation
import FirebaseAuth

@Observable
class HomeViewModel {
    var showSignOutAlert = false
    var showAddRecipeView = false
    
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
