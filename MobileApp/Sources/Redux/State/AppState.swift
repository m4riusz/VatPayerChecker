//
//  AppState.swift
//  MobileApp
//
//  Created by Mariusz Sut on 08/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

struct AppState: StateRedux {
    var mainState = MainState()
    var searchTabState = SearchTabState()
    var aboutTabState = AboutTabState()
}
