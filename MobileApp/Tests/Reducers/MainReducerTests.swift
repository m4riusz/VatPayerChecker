//
//  MainReducerTests.swift
//  MobileApp
//
//  Created by Mariusz Sut on 27/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import XCTest
import Core
import TestKit

@testable import MobileApp

final class MainReducerTests: BaseTestCase {
    private lazy var initialState = AppState(mainState: .init(tab: .vatTaxpayer),
                                             searchTabState: .init(searchQuery: "",
                                                                   searchDate: .from(year: 1990, month: 1, day: 1),
                                                                   showDatePicker: false,
                                                                   searchOption: .nip,
                                                                   status: .ready),
                                             aboutTabState: .init(status: .ready))
    private lazy var store = AppStore(initialState: initialState,
                                      reducer: AppReducer.reduce,
                                      middlewares: [])
    
    func testSetTab() {
        store.dispatch(MainAction.openAboutTab)
        XCTAssertEqual(store.state.mainState.tab, .about)
    }
}
