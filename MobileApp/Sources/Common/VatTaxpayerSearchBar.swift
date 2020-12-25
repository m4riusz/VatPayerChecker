//
//  VatTaxpayerSearchBar.swift
//  MobileApp
//
//  Created by Mariusz Sut on 21/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Core
import Common
import SFSafeSymbols

struct VatTaxpayerSearchBar: View {
    private typealias Literals = MobileAppStrings
    private let searchDate: Binding<Date>
    private let searchText: Binding<String>
    private let searchOption: Binding<Option>
    private let error: String?
    private let onSearchTap: VoidHandler
    private let onDateTap: VoidHandler
    
    init(searchDate: Binding<Date>,
         searchText: Binding<String>,
         searchOption: Binding<Option>,
         error: String?,
         onSearchTap: @escaping VoidHandler,
         onDateTap: @escaping VoidHandler) {
        self.searchDate = searchDate
        self.searchText = searchText
        self.searchOption = searchOption
        self.error = error
        self.onSearchTap = onSearchTap
        self.onDateTap = onDateTap
    }
    
    var body: some View {
        LazyVStack {
            Text(Literals.findCompany)
                .font(.title)
                .fontWeight(.semibold)
            VPTextField(placeholder: placeholderText,
                        text: searchText,
                        error: error,
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
                             error: "error",
                             onSearchTap: { /*Nop*/ },
                             onDateTap: { /*Nop*/ })
    }
}
