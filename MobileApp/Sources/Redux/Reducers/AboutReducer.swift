//
//  AboutReducer.swift
//  MobileApp
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

struct AboutReducer {
    static func reduce(state: AboutTabState, action: Action) -> AboutTabState {
        guard let action = action as? AboutAction else {
            return state
        }
        var mutableState = state
        switch action {
        case .setResult(let result):
            mutableState.status = .loaded(about: result)
        case .load:
            break
        }
        return mutableState
    }
}
