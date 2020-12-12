//
//  SearchTabState.swift
//  MobileApp
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Core

enum SearchTabLoadable {
    case ready
    case loading
    case success(_ vatTaxpayer: VatTaxpayer)
    case error(_ error: VatError)
}

extension SearchTabLoadable: Equatable { /*Nop*/ }

struct SearchTabState: StateRedux {
    var searchQuery = ""
    var searchDate = Date()
    var showDatePicker = false
    var searchOption: VatTaxpayerSearchBar.Option = .nip
    var status: SearchTabLoadable = .ready
}