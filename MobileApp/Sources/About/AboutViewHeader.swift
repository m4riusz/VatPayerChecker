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
    let appName: String
    let apiDescription: String
    let apiUrl: String
    let onUrlTap: VoidHandler
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 10) {
            Text(appName)
                .font(.title)
                .fontWeight(.bold)
            Text(apiDescription)
                .font(.body)
            Text(apiUrl)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .onTapGesture { onUrlTap() }
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
