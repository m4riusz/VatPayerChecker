//
//  VPTextField.swift
//  Common
//
//  Created by Mariusz Sut on 28/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

public struct VPTextField: View {
    let placeholder: String
    let text: Binding<String>
    let clearImage: Image?
    
    public init(placeholder: String, text: Binding<String>, clearImage: Image?) {
        self.placeholder = placeholder
        self.text = text
        self.clearImage = clearImage
    }
    
    public var body: some View {
        VStack {
            if let image = clearImage {
                TextField(placeholder, text: text)
                    .modifier(VPTextFieldClearButtonModifier(clearImage: image, text: text))
                    .foregroundColor(.accentColor)
                    .font(.body)
                    .padding()
            } else {
                TextField(placeholder, text: text)
                    .foregroundColor(.accentColor)
                    .font(.body)
                    .padding()
            }
        }
        .border(Color.accentColor)
    }
}

struct VPTextField_Previews: PreviewProvider {
    private static var text: Binding<String> {
        Binding<String>(get: { "" }, set: { _ in })
    }
    
    static var previews: some View {
        VPTextField(placeholder: "Placeholder", text: text, clearImage: nil)
    }
}
