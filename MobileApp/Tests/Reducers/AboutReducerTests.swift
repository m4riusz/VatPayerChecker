//
//  AboutReducerTests.swift
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

final class AboutReducerTests: BaseTestCase {
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
    
    func testLoad() {
        let orginalState = initialState
        store.dispatch(AboutAction.load)
        XCTAssertEqual(initialState, orginalState)
    }
    
    func testSetResult() {
        let about = About(apiUrl: "someUrl",
                          usedLibraries: [.init(name: "Library", url: "url", license: "License")])
        store.dispatch(AboutAction.setResult(about))
        XCTAssertEqual(store.state.aboutTabState.status, .loaded(about: about))
    }
}
