//
//  VatTaxpayerTextRow.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

struct VatTaxpayerTextRow: View {
    let title: String
    let values: [String]
    
    init(title: String, value: String) {
        self.init(title: title, values: [value])
    }
    
    init(title: String, values: [String]) {
        self.title = title
        self.values = values
    }
    
    var body: some View {
        Section(header: Text(title)
                    .font(.caption),
                content: {
                    ForEach(values, id: \.self) { text in
                        Text(text)
                            .font(.body)
                            .bold()
                    }
                })
    }
}

struct VatTaxpayerTextRow_Previews: PreviewProvider {
    static var previews: some View {
        VatTaxpayerTextRow(title: "Name", value: "Januszex")
    }
}
