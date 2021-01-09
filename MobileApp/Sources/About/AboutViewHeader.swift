//
//  AboutViewHeader.swift
//  MobileApp
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Core

struct AboutViewHeader: View {
    private struct Identifiers {
        static let appName = "AppNameIdentifier"
        static let apiDescription = "ApiDescriptionIdentifier"
        static let apiUrl = "ApiUrlIdentifier"
        
    }
    let appName: String
    let apiDescription: String
    let apiUrl: String
    let onUrlTap: VoidHandler
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 10) {
            Text(appName)
                .font(.title)
                .fontWeight(.bold)
                .accessibilityIdentifier(Identifiers.appName)
            Text(apiDescription)
                .font(.body)
                .accessibilityIdentifier(Identifiers.apiDescription)
            Text(apiUrl)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .onTapGesture { onUrlTap() }
                .accessibilityIdentifier(Identifiers.apiUrl)
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct AboutViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        AboutViewHeader(appName: "VatTaxpayerChecker",
                        apiDescription: "Some desc",
                        apiUrl: "someUrl",
                        onUrlTap: { /*Nop*/ })
    }
}
