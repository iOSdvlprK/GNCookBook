//
//  AddRecipeView.swift
//  GNCookBook
//
//  Created by joe on 2/25/26.
//

import SwiftUI

struct AddRecipeView: View {
    @State private var recipeName = ""
    @State private var preparationTime = 0
    @State private var instructions = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("What's New")
                .font(.system(size: 26, weight: .bold))
                .padding(.top, 20)
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(.primaryFormEntry)
                    .frame(height: 200)
                Image(systemName: "photo.fill")
            }
            Text("Recipe Name")
                .font(.system(size: 15, weight: .semibold))
                .padding(.top)
            TextField("", text: $recipeName)
                .textFieldStyle(CapsuleTextFieldStyle())
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            Text("Preparation Time")
                .font(.system(size: 15, weight: .semibold))
                .padding(.top)
            Picker(selection: $preparationTime) {
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
            TextEditor(text: $instructions)
                .frame(height: 150)
                .background(.primaryFormEntry)
                .scrollContentBackground(.hidden)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Button(action: {
                
            }, label: {
                Text("Add Recipe")
            })
            .buttonStyle(PrimaryButtonStyle())
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    AddRecipeView()
}
