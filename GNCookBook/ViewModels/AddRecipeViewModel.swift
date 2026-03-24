//
//  AddRecipeViewModel.swift
//  GNCookBook
//
//  Created by joe on 2/27/26.
//

import SwiftUI
import FirebaseStorage
import FirebaseAuth

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
    
    func upload() async {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let recipeImage, let imageData = recipeImage.jpegData(compressionQuality: 0.7) else { return }
        
        let imageID = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "_")
        let imageName = "\(imageID).jpg"
        let imagePath = "images/\(userId)/\(imageName)"
        let storageRef = Storage.storage().reference(withPath: imagePath)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        do {
            let _ = try await storageRef.putDataAsync(imageData, metadata: metaData) { progress in
                if let progress {
                    let percentComplete = Float(progress.completedUnitCount / progress.totalUnitCount)
                    self.uploadProgress = percentComplete
                }
            }
        } catch {
            
        }
    }
}
