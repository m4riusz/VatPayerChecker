//
//  VPTextField.swift
//  Common
//
//  Created by Mariusz Sut on 28/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

public struct VPTextField: View {
    private let placeholder: String
    private let text: Binding<String>
    private let clearImage: Image
    private let error: String?
    
    public init(placeholder: String, text: Binding<String>, error: String?, clearImage: Image) {
        self.placeholder = placeholder
        self.text = text
        self.clearImage = clearImage
        self.error = error
    }
    
    public var body: some View {
        VStack {
            TextField(placeholder, text: text)
                .modifier(VPTextFieldClearButtonModifier(clearImage: clearImage, text: text))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.body)
            
            if let error = error {
                Text(error)
                    .foregroundColor(.red)
                    .fontWeight(.semibold)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding([.top, .bottom], 5)
    }
}

struct VPTextField_Previews: PreviewProvider {
    private static var text: Binding<String> {
        Binding<String>(get: { "text" }, set: { _ in })
    }
    
    private static var error: Binding<String?> {
        Binding<String?>(get: { "error" }, set: { _ in })
    }
    
    static var previews: some View {
        VPTextField(placeholder: "Placeholder",
                    text: text,
                    error: "error",
                    clearImage: Image(systemName: "play.circle"))
    }
}
