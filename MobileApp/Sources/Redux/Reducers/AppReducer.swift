//
//  AppReducer.swift
//  MobileApp
//
//  Created by Mariusz Sut on 11/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

struct AppReducer {
    static func reduce(state: AppState, action: Action) -> AppState {
        var mutableState = state
        mutableState.mainState = MainReducer.reduce(state: state.mainState, action: action)
        mutableState.searchTabState = SearchTabReducer.reduce(state: state.searchTabState, action: action)
        return mutableState
    }
}
