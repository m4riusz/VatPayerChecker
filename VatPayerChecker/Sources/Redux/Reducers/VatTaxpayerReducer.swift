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
        case .clearSearch:
            mutableState.query = nil
            mutableState.date = nil
            mutableState.status = .ready
        case .searchByNip(let nip, let date):
            mutableState.query = nip
            mutableState.date = date
            mutableState.status = .loading
        case .searchByRegon(let regon, let date):
            mutableState.query = regon
            mutableState.date = date
            mutableState.status = .loading
        case .searchByAccount(let account, let date):
            mutableState.query = account
            mutableState.date = date
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
