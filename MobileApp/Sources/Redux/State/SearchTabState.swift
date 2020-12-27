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
    case success(_ vatTaxpayer: ObjectResult<VatTaxpayer>)
    case error(_ error: VatError)
}

extension SearchTabLoadable: Equatable { /*Nop*/ }

struct SearchTabState: StateRedux {
    var searchQuery: String
    var searchDate: Date
    var showDatePicker: Bool
    var searchOption: VatTaxpayerSearchBar.Option
    var status: SearchTabLoadable
}

extension SearchTabState: Equatable { /*Nop*/ }
