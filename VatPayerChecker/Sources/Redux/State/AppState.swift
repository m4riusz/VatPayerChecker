//
//  AppState.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 08/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

struct AppState: State {
    var mainState = MainState()
    var vatTaxpayerState = VatTaxpayerSearchState()
}
