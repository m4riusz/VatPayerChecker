//
//  VatTaxpayerReducer.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

struct VatTaxpayerReducer {
    static func reduce(state: VatTaxpayerSearchState, action: Action) -> VatTaxpayerSearchState {
        guard let action = action as? VatTaxpayerAction else {
            return state
        }
        var mutableState = state
        switch action {
        case .setSearchDate(let date):
            mutableState.searchDate = date
        case .setSearchQuery(let query):
            mutableState.searchQuery = query
        case .setSearchOption(let option):
            mutableState.searchOption = option
        case .clearSearch:
            mutableState.searchQuery = ""
            mutableState.searchDate = Date()
            mutableState.searchOption = .nip
            mutableState.status = .ready
        case .searchByNip, .searchByRegon, .searchByAccount:
            mutableState.status = .loading
        case .setResult(let result):
            switch result {
            case .success(let vatTaxpayer):
                mutableState.status = .success(vatTaxpayer)
            case .failure(let error):
                mutableState.status = .error(error)
            }
        }
        return mutableState
    }
}
