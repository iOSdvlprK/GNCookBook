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
    var errorMessage = ""
    var presentAlert = false
    
    func signup() async -> Bool {
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
            return true
        } catch {
            errorMessage = "Login Failed"
            let errorCode = (error as NSError).code
            if let authErrorCode = AuthErrorCode(rawValue: errorCode) {
                switch authErrorCode {
                case .emailAlreadyInUse:
                    errorMessage = "Email Already In Use"
                case .invalidEmail:
                    errorMessage = "Invalid Email"
                default:
                    break
                }
            }
            isLoading = false
            presentAlert = true
            return false
        }
    }
}
