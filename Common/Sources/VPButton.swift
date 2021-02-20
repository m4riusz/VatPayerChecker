//
//  VPButton.swift
//  Common
//
//  Created by Mariusz Sut on 28/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

public struct VPButton: View {
    public enum Style {
        case link
        case action
    }
    
    private let style: Style
    private let text: String
    private let image: Image?
    private let action: () -> Void
    
    public init(style: Style, text: String, image: Image? = nil, action: @escaping () -> Void) {
        self.style = style
        self.text = text
        self.image = image
        self.action = action
    }
    
    public var body: some View {
        Button(action: action,
               label: {
                switch style {
                case .link:
                    content
                        .foregroundColor(.accentColor)
                case .action:
                    content
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(5)
                }
               })
    }
    
    var content: some View {
        HStack {
            if let image = image {
                image
                    .font(.body)
            }
            Text(text)
                .fontWeight(.semibold)
                .font(.body)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(10)
    }
}

struct VPButton_Previews: PreviewProvider {
    static var previews: some View {
        VPButton(style: .link,
                 text: "Text",
                 image: Image(systemName: "play.circle"),
                 action: { /*Nop*/})
    }
}
