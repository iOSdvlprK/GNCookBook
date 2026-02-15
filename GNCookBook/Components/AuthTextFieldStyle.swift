//
//  AuthTextFieldStyle.swift
//  GNCookBook
//
//  Created by joe on 2/15/26.
//

import SwiftUI

struct AuthTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.system(size: 14))
            .textInputAutocapitalization(.never)
        Rectangle()
            .fill(.border)
            .frame(height: 1)
            .padding(.bottom, 15)
    }
}
