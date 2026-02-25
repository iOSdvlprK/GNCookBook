//
//  CapsuleTextFieldStyle.swift
//  GNCookBook
//
//  Created by joe on 2/25/26.
//

import SwiftUI

struct CapsuleTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background {
                Capsule()
                    .fill(.primaryFormEntry)
            }
    }
}
