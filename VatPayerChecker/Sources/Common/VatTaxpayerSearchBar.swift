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
    private typealias Literals = VatPayerCheckerStrings
    var searchDate: Binding<Date>
    var searchText: Binding<String>
    var searchOption: Binding<Option>
    var onSearchTap: VoidHandler
    var onDateTap: VoidHandler
    
    init(searchDate: Binding<Date>,
         searchText: Binding<String>,
         searchOption: Binding<Option>,
         onSearchTap: @escaping VoidHandler,
         onDateTap: @escaping VoidHandler) {
        self.searchDate = searchDate
        self.searchText = searchText
        self.searchOption = searchOption
        self.onSearchTap = onSearchTap
        self.onDateTap = onDateTap
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(searchDate.wrappedValue.yyyyMMdd) {
                    onDateTap()
                }
                TextField(placeholderText, text: searchText)
                    .modifier(TextFieldClearButtonModifier(text: searchText))
                Button(Literals.searchButton) {
                    onSearchTap()
                }
                .disabled(searchText.wrappedValue.isEmpty)
            }
            Picker("", selection: searchOption) {
                Text(Literals.searchByNip).tag(Option.nip)
                Text(Literals.searchByRegon).tag(Option.regon)
                Text(Literals.searchByAccount).tag(Option.account)
            }.pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }
    
    private var placeholderText: String {
        switch searchOption.wrappedValue {
        case .nip:
            return Literals.searchByNipPlaceholder
        case .regon:
            return Literals.searchByRegonPlaceholder
        case .account:
            return Literals.searchByAccountNumberPlaceholder
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
    private static var searchDate: Binding<Date> {
        Binding<Date>(get: { Date() }, set: { _ in })
    }
    
    private static var searchText: Binding<String> {
        Binding<String>(get: { "" }, set: { _ in })
    }
    
    private static var searchOption: Binding<VatTaxpayerSearchBar.Option> {
        Binding<VatTaxpayerSearchBar.Option>(get: { .nip }, set: { _ in })
    }
    
    static var previews: some View {
        VatTaxpayerSearchBar(searchDate: searchDate,
                             searchText: searchText,
                             searchOption: searchOption,
                             onSearchTap: { /*Nop*/ },
                             onDateTap: { /*Nop*/ })
    }
}
