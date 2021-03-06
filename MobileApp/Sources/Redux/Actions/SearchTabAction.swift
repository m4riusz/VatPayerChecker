//
//  SearchTabAction.swift
//  MobileApp
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Core

enum SearchTabAction: Action {
    case setSearchDate(_ date: Date)
    case setSearchQuery(_ query: String)
    case setSearchOption(_ option: VatTaxpayerSearchBar.Option)
    case clearSearch
    case searchByNip(_ nip: String, date: Date)
    case searchByRegon(_ regon: String, date: Date)
    case searchByAccount(_ account: String, date: Date)
    case setResult(_ result: Result<ObjectResult<VatTaxpayer>, VatError>)
    case showDatePicker
    case hideDatePicker
}

extension SearchTabAction: Equatable { /*Nop*/ }
