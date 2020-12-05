//
//  VatTaxpayerSearchState.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Core

enum VatTaxpayerLoadable {
    case ready
    case loading
    case success(_ vatTaxpayer: VatTaxpayer)
    case error(_ error: VatError)
}

extension VatTaxpayerLoadable: Equatable { /*Nop*/ }

struct VatTaxpayerSearchState: StateRedux {
    var searchQuery = ""
    var searchDate = Date()
    var searchOption: VatTaxpayerSearchBar.Option = .nip
    var status: VatTaxpayerLoadable = .ready
}
