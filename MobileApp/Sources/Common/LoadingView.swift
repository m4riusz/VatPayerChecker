//
//  LoadingView.swift
//  MobileApp
//
//  Created by Mariusz Sut on 05/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    let text: String
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.7)
            ProgressView(text)
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .foregroundColor(.accentColor)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.accentColor)
                )
                .background(Color(UIColor.systemBackground))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(text: "Searching")
    }
}
