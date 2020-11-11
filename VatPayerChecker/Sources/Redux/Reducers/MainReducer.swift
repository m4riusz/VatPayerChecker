//
//  MainReducer.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 08/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

struct MainReducer {
    static func reduce(state: MainState, action: Action) -> MainState {
        guard let action = action as? MainAction else {
            return state
        }
        var mutableState = state
        switch action {
        case .openVatTaxpayerTab:
            mutableState.tab = .vatTaxpayer
        case .openAboutTab:
            mutableState.tab = .about
        }
        return mutableState
    }
}
