//
//  VatTaxpayerTextRow.swift
//  MobileApp
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Common

struct VatTaxpayerTextRow: View {
    typealias ValueCallback = (String) -> Void
    let title: String
    let values: [String]
    let actionButton: String?
    let action: ValueCallback?
    
    init(title: String, value: String, actionButton: String? = nil, action: ValueCallback? = nil) {
        self.init(title: title, values: [value], actionButton: actionButton, action: action)
    }
    
    init(title: String, values: [String], actionButton: String? = nil, action: ValueCallback? = nil) {
        self.title = title
        self.values = values
        self.actionButton = actionButton
        self.action = action
    }
    
    var body: some View {
        Section(header:
                    HStack {
                        Text(title)
                            .font(.caption)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(8)
                    .background(Color.accentColor)
                    .listRowInsets(EdgeInsets()),
                content: {
                    ForEach(values, id: \.self) { text in
                        HStack(spacing: 5) {
                            Text(text)
                                .font(.body)
                                .bold()
                            Spacer()
                            if let actionText = actionButton, let callback = action {
                                Button(action: {
                                    callback(text)
                                }, label: {
                                    Text(actionText)
                                        .fontWeight(.bold)
                                        .foregroundColor(.accentColor)
                                })
                            }
                        }
                    }
                }).buttonStyle(PlainButtonStyle())
    }
}

struct VatTaxpayerTextRow_Previews: PreviewProvider {
    static var previews: some View {
        VatTaxpayerTextRow(title: "Name",
                           value: "Januszex",
                           actionButton: "Kopiuj",
                           action: { _ in /*Nop*/ })
    }
}
