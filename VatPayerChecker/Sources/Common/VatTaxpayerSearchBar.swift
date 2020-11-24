//
//  VatTaxpayerSearchBar.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 21/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Core
 
struct VatTaxpayerSearchBar: View {
    var searchText: Binding<String>
    var searchOption: Binding<Option>
    var onSearchTap: VoidHandler
    
    init(searchText: Binding<String>, searchOption: Binding<Option>, onSearchTap: @escaping VoidHandler) {
        self.searchText = searchText
        self.searchOption = searchOption
        self.onSearchTap = onSearchTap
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField(placeholderText, text: searchText)
                Button("SEARCH") {
                    onSearchTap()
                }
            }
            Picker("", selection: searchOption) {
                Text("Nip").tag(Option.nip)
                Text("Account").tag(Option.account)
                Text("Regon").tag(Option.regon)
            }.pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }
    
    private var placeholderText: String {
        switch searchOption.wrappedValue {
        case .nip:
            return "Type NIP"
        case .regon:
            return "Type REGON"
        case .account:
            return "Type Account"
        }
    }
}

extension VatTaxpayerSearchBar {
    enum Option {
        case nip
        case account
        case regon
    }
}

struct VatTaxpayerSearchBar_Previews: PreviewProvider {
    private static var searchText: Binding<String> {
        Binding<String>(get: { "" }, set: { _ in })
    }
    
    private static var searchOption: Binding<VatTaxpayerSearchBar.Option> {
        Binding<VatTaxpayerSearchBar.Option>(get: { .nip }, set: { _ in })
    }
    
    static var previews: some View {
        VatTaxpayerSearchBar(searchText: searchText,
                             searchOption: searchOption,
                             onSearchTap: { /*Nop*/ })
    }
}
