//
//  SearchTabReducerTests.swift
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

final class SearchTabReducerTests: BaseTestCase {
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
    
    func testSetQuery() {
        store.dispatch(SearchTabAction.setSearchQuery("Query"))
        XCTAssertEqual(store.state.searchTabState.searchQuery, "Query")
    }
    
    func testSetDate() {
        let date = Date.from(year: 2000, month: 2, day: 2)
        store.dispatch(SearchTabAction.setSearchDate(date))
        XCTAssertEqual(store.state.searchTabState.searchDate, date)
    }
    
    func testShowPicker() {
        store.dispatch(SearchTabAction.showDatePicker)
        XCTAssertEqual(store.state.searchTabState.showDatePicker, true)
    }
    
    func testHidePicker() {
        store.dispatch(SearchTabAction.hideDatePicker)
        XCTAssertEqual(store.state.searchTabState.showDatePicker, false)
    }
    
    func testSetSearchOption() {
        store.dispatch(SearchTabAction.setSearchOption(.account))
        XCTAssertEqual(store.state.searchTabState.searchOption, .account)
    }
    
    func testSetLoadableSuccessStatus() {
        let vatTaxpayer = ObjectResult<VatTaxpayer>(subject: .stub(name: "Name"),
                                                    requestDateTime: "requestDateTime",
                                                    requestId: "requestId")
        store.dispatch(SearchTabAction.setResult(.success(vatTaxpayer)))
        XCTAssertEqual(store.state.searchTabState.status, .success(vatTaxpayer))
    }
    
    func testSetLoadableFailureStatus() {
        store.dispatch(SearchTabAction.setResult(.failure(.invalidNip)))
        XCTAssertEqual(store.state.searchTabState.status, .error(.invalidNip))
    }
    
    func testSetLoadableLoadingStatusNip() {
        store.dispatch(SearchTabAction.searchByAccount("", date: .now))
        XCTAssertEqual(store.state.searchTabState.status, .loading)
    }
    
    func testSetLoadableLoadingStatusRegon() {
        store.dispatch(SearchTabAction.searchByRegon("", date: .now))
        XCTAssertEqual(store.state.searchTabState.status, .loading)
    }
    
    func testSetLoadableLoadingStatusAccount() {
        store.dispatch(SearchTabAction.searchByAccount("", date: .now))
        XCTAssertEqual(store.state.searchTabState.status, .loading)
    }
    
    func testClearSearch() {
        store.dispatch(SearchTabAction.clearSearch)
        let state = store.state.searchTabState
        XCTAssertEqual(state.searchQuery, "")
        XCTAssertEqual(state.searchOption, .nip)
        XCTAssertEqual(state.showDatePicker, false)
        XCTAssertEqual(state.status, .ready)
    }
}
