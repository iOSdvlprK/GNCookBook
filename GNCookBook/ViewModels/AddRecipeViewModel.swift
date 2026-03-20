//
//  AddRecipeViewModel.swift
//  GNCookBook
//
//  Created by joe on 2/27/26.
//

import SwiftUI

@Observable
class AddRecipeViewModel {
    var recipeName = ""
    var preparationTime = 0
    var instructions = ""
    var showImageOptions = false
    var showLibrary = false
    var displayedRecipeImage: Image?
}
