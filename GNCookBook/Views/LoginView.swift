//
//  LoginView.swift
//  GNCookBook
//
//  Created by joe on 2/12/26.
//

import SwiftUI

struct LoginView: View {
    @State var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Email")
                .font(.system(size: 15))
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textFieldStyle(AuthTextFieldStyle())
            Text("Password")
                .font(.system(size: 15))
            SecureField("Password", text: $viewModel.password)
                .font(.system(size: 14))
            Rectangle()
                .fill(.border)
                .frame(height: 1)
                .padding(.bottom, 15)
            
            Button(action: {
                
            }, label: {
                Text("Login")
                    .font(.system(size: 15, weight: .semibold))
                    .padding(12)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            })
            
            HStack {
                Spacer()
                Text("Don't have an account?")
                    .font(.system(size: 14))
                Button(action: {
                    viewModel.presentRegisterView = true
                }, label: {
                    Text("Register now")
                        .font(.system(size: 14, weight: .semibold))
                })
                Spacer()
            }
            .padding(.top, 20)
        }
        .padding(.horizontal, 10)
        .fullScreenCover(isPresented: $viewModel.presentRegisterView) {
            RegisterView()
        }
    }
}

#Preview {
    LoginView()
}
