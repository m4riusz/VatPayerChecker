//
//  VatTaxpayerSingleValueRow.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

struct VatTaxpayerSingleValueRow: View {
    let title: String
    let value: String
    
    init?(title: String, value: String?) {
        guard let value = value else {
            return nil
        }
        self.title = title
        self.value = value
    }
    
    var body: some View {
        Section(header: Text(title)
                    .bold()
                    .font(.title2),
                content: {
                    Text(value)
                        .font(.body)
                })
    }
}

struct VatTaxpayerSingleValueRow_Previews: PreviewProvider {
    static var previews: some View {
        VatTaxpayerSingleValueRow(title: "Name", value: "Januszex")
    }
}
