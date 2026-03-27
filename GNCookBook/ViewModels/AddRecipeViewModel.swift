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
    
    func addRecipe() async {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard recipeName.count >= 2 else { return }
        guard instructions.count >= 5 else { return }
        guard preparationTime != 0 else { return }
        guard let imageURL = await upload() else { return }
        let ref = Firestore.firestore().collection("recipes").document()
        let recipe = Recipe(id: ref.documentID, name: recipeName, image: imageURL.absoluteString, instructions: instructions, time: preparationTime, userId: userId)
        do {
            try Firestore.firestore().collection("recipes").document(ref.documentID).setData(from: recipe)
        } catch {
            print("DEBUG: Recipe Upload failed.")
        }
    }
    
    func upload() async -> URL? {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("DEBUG: Upload failed - User not authenticated.")
            return nil
        }
        
        guard let recipeImage else {
            print("DEBUG: Upload failed - No image selected.")
            return nil
        }
        
        guard let imageData = recipeImage.jpegData(compressionQuality: 0.7) else {
            print("DEBUG: Upload failed - Could not convert image to JPEG data.")
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
            print("DEBUG: Upload failed with error: \(error.localizedDescription)")
            return nil
        }
    }
}
