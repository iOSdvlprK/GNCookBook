//
//  LoginView.swift
//  GNCookBook
//
//  Created by joe on 2/12/26.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Email")
                .font(.system(size: 15))
            TextField("Email", text: $email)
                .font(.system(size: 14))
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
            Rectangle()
                .frame(height: 1)
                .padding(.bottom, 15)
            Text("Password")
                .font(.system(size: 15))
            SecureField("Password", text: $password)
                .font(.system(size: 14))
            Rectangle()
                .frame(height: 1)
                .padding(.bottom, 15)
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    LoginView()
}
