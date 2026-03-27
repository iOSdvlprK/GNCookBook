//
//  AddRecipeView.swift
//  GNCookBook
//
//  Created by joe on 2/25/26.
//

import SwiftUI
import PhotosUI

struct AddRecipeView: View {
    @State private var viewModel = AddRecipeViewModel()
    @State private var imageLoaderViewModel = ImageLoaderViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("What's New")
                    .font(.system(size: 26, weight: .bold))
                    .padding(.top, 20)
                ZStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.primaryFormEntry)
                            .frame(height: 200)
                        Image(systemName: "photo.fill")
                    }
                    if let displayedRecipeImage = viewModel.displayedRecipeImage {
                        displayedRecipeImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .clipped()
                    }
                }
                .onTapGesture {
                    viewModel.showImageOptions = true
                }
                Text("Recipe Name")
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.top)
                TextField("", text: $viewModel.recipeName)
                    .textFieldStyle(CapsuleTextFieldStyle())
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                Text("Preparation Time")
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.top)
                Picker(selection: $viewModel.preparationTime) {
                    ForEach(stride(from: 0, through: 120, by: 5).map { $0 }, id: \.self) { time in
                        Text("\(time) mins")
                            .font(.system(size: 15))
                            .tag(time)
                    }
                } label: {
                    Text("Prep Time")
                }
                Text("Cooking Instructions")
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.top)
                TextEditor(text: $viewModel.instructions)
                    .frame(height: 150)
                    .background(.primaryFormEntry)
                    .scrollContentBackground(.hidden)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Button(action: {
                    Task {
                        await viewModel.addRecipe()
                    }
                }, label: {
                    Text("Add Recipe")
                })
                .buttonStyle(PrimaryButtonStyle())
                Spacer()
            }
            .padding(.horizontal)
            .photosPicker(isPresented: $viewModel.showLibrary, selection: $imageLoaderViewModel.imageSelection, matching: .images, photoLibrary: .shared())
            .onChange(of: imageLoaderViewModel.imageToUpload, { _, newValue in
                if let newValue {
                    viewModel.displayedRecipeImage = Image(uiImage: newValue)
                    viewModel.recipeImage = newValue
                }
            })
            .confirmationDialog("Upload an image to your recipe", isPresented: $viewModel.showImageOptions, titleVisibility: .visible) {
                Button(action: {
                    viewModel.showLibrary = true
                }, label: {
                    Text("Upload from Library")
                })
                Button(action: {
                    viewModel.showCamera = true
                }, label: {
                    Text("Upload from Camera")
                })
                Button(action: {
                    
                }, label: {
                    Text("Cancel")
                })
            }
            .fullScreenCover(isPresented: $viewModel.showCamera) {
                CameraPicker { image in
                    viewModel.displayedRecipeImage = Image(uiImage: image)
                    viewModel.recipeImage = image
                }
            }
            if viewModel.isUploading {
                ProgressComponentView(value: $viewModel.uploadProgress)
            }
        }
    }
}

#Preview {
    AddRecipeView()
}
