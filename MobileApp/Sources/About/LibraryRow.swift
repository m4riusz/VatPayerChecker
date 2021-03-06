//
//  LibraryRow.swift
//  MobileApp
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Core

struct LibraryRow: View {
    private struct Identifiers {
        static let name = "NameIdentifier"
        static let url = "UrlIdentifier"
        static let license = "LicenseIdentifier"
    }
    let library: Library
    let onLinkTap: VoidHandler
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 10) {
            Text(library.name)
                .font(.title2)
                .fontWeight(.medium)
                .accessibilityIdentifier(Identifiers.name)
            Text(library.url)
                .font(.body)
                .fontWeight(.regular)
                .foregroundColor(.blue)
                .onTapGesture { onLinkTap() }
                .accessibilityIdentifier(Identifiers.url)
            Text(library.license)
                .font(.callout)
                .fontWeight(.light)
                .accessibilityIdentifier(Identifiers.license)
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity)
    }
}

struct LibraryRow_Previews: PreviewProvider {
    static var previews: some View {
        LibraryRow(library: Library(name: "Name",
                                    url: "url",
                                    license: "some licence text"),
                   onLinkTap: { /*Nop*/ })
    }
}
