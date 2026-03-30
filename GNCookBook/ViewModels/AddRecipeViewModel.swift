//
//  AddRecipeViewModel.swift
//  GNCookBook
//
//  Created by joe on 2/27/26.
//

import SwiftUI
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

@Observable
class AddRecipeViewModel {
    var recipeName = ""
    var preparationTime = 0
    var instructions = ""
    var showImageOptions = false
    var showLibrary = false
    var displayedRecipeImage: Image?
    var recipeImage: UIImage?
    var showCamera = false
    var uploadProgress: Float = 0
    var isUploading = false
    var isLoading = false
    var showAlert = false
    var alertTitle = ""
    var alertMessage = ""
    
    func addRecipe(imageURL: URL, handler: @escaping (_ success: Bool) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            createAlert(title: "Not Signed In", message: "Please sign in to create recipes.")
            handler(false)
            return
        }
        guard recipeName.count >= 2 else {
            createAlert(title: "Invalid Recipe Name", message: "Recipe name must be 2 or more characters long.")
            handler(false)
            return
        }
        guard instructions.count >= 5 else {
            createAlert(title: "Invalid Instructions", message: "Instructions must be 5 or more characters long.")
            handler(false)
            return
        }
        guard preparationTime != 0 else {
            createAlert(title: "Invalid Preparation Time", message: "Preparation time must be greater than 0 minutes.")
            handler(false)
            return
        }
        isLoading = true
        let ref = Firestore.firestore().collection("recipes").document()
        let recipe = Recipe(id: ref.documentID, name: recipeName, image: imageURL.absoluteString, instructions: instructions, time: preparationTime, userId: userId)
        do {
            try Firestore.firestore().collection("recipes").document(ref.documentID).setData(from: recipe) { error in
                self.isLoading = false
                if let error {
                    print(error.localizedDescription)
                    self.createAlert(title: "Could Not Save Recipe", message: "We could not save your recipe right now. Please try later.")
                    handler(false)
                    return
                }
                handler(true)
            }
        } catch {
            print("DEBUG: Recipe Upload failed.")
            createAlert(title: "Could Not Save Recipe", message: "We could not save your recipe right now. Please try later.")
            isLoading = false
            handler(false)
        }
    }
    
    private func createAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    func upload() async -> URL? {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("DEBUG: Upload failed - User not authenticated.")
            return nil
        }
        
        guard let recipeImage else {
            print("DEBUG: Upload failed - No image selected.")
            createAlert(title: "Image Upload Failed", message: "Your recipe image is not selected.")
            return nil
        }
        
        guard let imageData = recipeImage.jpegData(compressionQuality: 0.7) else {
            print("DEBUG: Upload failed - Could not convert image to JPEG data.")
            createAlert(title: "Image Upload Failed", message: "Your recipe image could not be uploaded.")
            return nil
        }
        
        let imageID = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "_")
        let imageName = "\(imageID).jpg"
        let imagePath = "images/\(userId)/\(imageName)"
        let storageRef = Storage.storage().reference(withPath: imagePath)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        isUploading = true
        
        do {
            let _ = try await storageRef.putDataAsync(imageData, metadata: metaData) { progress in
                if let progress {
                    let percentComplete = Float(progress.completedUnitCount / progress.totalUnitCount)
                    self.uploadProgress = percentComplete
                }
            }
            isUploading = false
            let downloadURL = try await storageRef.downloadURL()
            return downloadURL
        } catch {
            isUploading = false
            createAlert(title: "Image Upload Failed", message: "Your recipe image could not be uploaded.")
            print("DEBUG: Upload failed with error: \(error.localizedDescription)")
            return nil
        }
    }
}
