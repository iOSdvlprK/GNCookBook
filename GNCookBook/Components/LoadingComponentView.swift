//
//  LoadingComponentView.swift
//  GNCookBook
//
//  Created by joe on 3/10/26.
//

import SwiftUI

struct LoadingComponentView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
            ProgressView()
                .tint(Color.white)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoadingComponentView()
}
