//
//  TabViewItem.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 11/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import SFSafeSymbols

struct TabViewItem: View {
    let title: String
    let image: SFSymbol
    
    var body: some View {
        VStack {
            Image(systemSymbol: image)
                .font(.headline)
            Text(title)
                .fontWeight(.medium)
                .font(.headline)
                .lineLimit(1)
        }
        .padding(10)
    }
}

struct TabViewItem_Previews: PreviewProvider {
    static var previews: some View {
        TabViewItem(title: "Play",
                    image: .play)
    }
}
