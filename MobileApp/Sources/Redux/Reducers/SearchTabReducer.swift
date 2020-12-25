//
//  SearchTabReducer.swift
//  MobileApp
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

struct SearchTabReducer {
    static func reduce(state: SearchTabState, action: Action) -> SearchTabState {
        guard let action = action as? SearchTabAction else {
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
            mutableState.showDatePicker = false
        case .searchByNip, .searchByRegon, .searchByAccount:
            mutableState.status = .loading
        case .setResult(let result):
            switch result {
            case .success(let object):
                mutableState.status = .success(object)
            case .failure(let error):
                mutableState.status = .error(error)
            }
        case .showDatePicker:
            mutableState.showDatePicker = true
        case .hideDatePicker:
            mutableState.showDatePicker = false
        }
        return mutableState
    }
}
