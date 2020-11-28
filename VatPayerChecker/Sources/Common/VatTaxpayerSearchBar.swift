//
//  VatTaxpayerSearchBar.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 21/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Core
import Common
import SFSafeSymbols

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
            VPTextField(placeholder: placeholderText,
                        text: searchText,
                        clearImage: Image(systemSymbol: .deleteLeft))
                .frame(maxWidth: .infinity)
            VPSegmentControl<Option>(items: [.nip, .regon, .account],
                                     selection: searchOption)
                .frame(maxWidth: .infinity, maxHeight: 50)
            VPButton(style: .link,
                     text: searchDate.wrappedValue.yyyyMMdd,
                     image: Image(systemSymbol: .calendar),
                     action: onDateTap)
                .frame(maxWidth: .infinity)
            VPButton(style: .action,
                     text: Literals.searchButton,
                     image: Image(systemSymbol: .magnifyingglass),
                     action: onSearchTap)
                .frame(maxWidth: .infinity)
        }
        .padding(10)
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
    enum Option: VPSegmentControlItem {
        case nip
        case account
        case regon
        
        var text: String {
            switch self {
            case .nip:
                return Literals.searchByNip
            case .regon:
                return Literals.searchByRegon
            case .account:
                return Literals.searchByAccount
            }
        }
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
