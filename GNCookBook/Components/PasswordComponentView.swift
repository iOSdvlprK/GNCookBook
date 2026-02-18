//
//  PasswordComponentView.swift
//  GNCookBook
//
//  Created by joe on 2/18/26.
//

import SwiftUI

struct PasswordComponentView: View {
    @Binding var showPassword: Bool
    @Binding var password: String
    
    var body: some View {
        Group {
            if showPassword {
                TextField("Password", text: $password)
            } else {
                SecureField("Password", text: $password)
            }
        }
        .font(.system(size: 14))
        .overlay(alignment: .trailing) {
            Button(action: {
                showPassword.toggle()
            }, label: {
                Image(systemName: showPassword ? "eye" : "eye.slash")
                    .foregroundStyle(.black)
                    .padding(.bottom, 4)
            })
        }
        Rectangle()
            .fill(.border)
            .frame(height: 1)
            .padding(.bottom, 15)
    }
}

#Preview {
    PasswordComponentView(showPassword: .constant(false), password: .constant(""))
}
