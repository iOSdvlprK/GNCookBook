//
//  RegisterViewModel.swift
//  GNCookBook
//
//  Created by joe on 2/19/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class RegisterViewModel {
    var username = ""
    var email = ""
    var showPassword = false
    var password = ""
    var isLoading = false
    
    func signup() async {
        do {
            isLoading = true
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let userId = result.user.uid
            let userData: [String: Any] = [
                "username": username,
                "email": email
            ]
            try await Firestore.firestore().collection("users").document(userId).setData(userData)
            isLoading = false
        } catch {
            isLoading = false
        }
    }
}
