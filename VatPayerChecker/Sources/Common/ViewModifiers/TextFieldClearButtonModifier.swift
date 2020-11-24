//
//  TextFieldClearButtonModifier.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 24/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

struct TextFieldClearButtonModifier: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            if !text.isEmpty {
                Button(
                    action: {
                        text = ""
                    },
                    label: {
                        Image(systemName: "delete.left")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
    }
}
