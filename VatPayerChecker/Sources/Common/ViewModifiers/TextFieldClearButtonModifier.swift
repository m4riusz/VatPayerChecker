//
//  TextFieldClearButtonModifier.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 24/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

struct TextFieldClearButtonModifier: ViewModifier {
    private typealias Images = VatPayerCheckerAsset
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
                        Image(uiImage: Images.deleteLeft.image)
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
    }
}
