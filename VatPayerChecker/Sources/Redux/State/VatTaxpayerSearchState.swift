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

struct VatTaxpayerSearchState: State {
    var query: String?
    var date: Date?
    var status: VatTaxpayerLoadable = .ready
}
