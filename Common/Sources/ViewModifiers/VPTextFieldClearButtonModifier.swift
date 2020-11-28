//
//  VPTextFieldClearButtonModifier.swift
//  Common
//
//  Created by Mariusz Sut on 24/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

struct VPTextFieldClearButtonModifier: ViewModifier {
    private let clearImage: Image
    private let text: Binding<String>
    
    init(clearImage: Image, text: Binding<String>) {
        self.clearImage = clearImage
        self.text = text
    }
    
    func body(content: Content) -> some View {
        HStack {
            content
            if !text.wrappedValue.isEmpty {
                Button(
                    action: {
                        text.wrappedValue = ""
                    },
                    label: {
                        clearImage
                            .foregroundColor(Color.accentColor)
                    }
                )
            }
        }
    }
}
