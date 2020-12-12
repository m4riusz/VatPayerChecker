//
//  VatTaxpayerSearchTab.swift
//  MobileApp
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Combine
import Core

struct VatTaxpayerSearchTab: View {
    private typealias Literals = MobileAppStrings
    @EnvironmentObject var store: AppStore
    private var state: SearchTabState {
        store.state.searchTabState
    }
    
    var body: some View {
        getByState(status: state.status)
    }
    
    private func getByState(status: SearchTabLoadable) -> some View {
        NavigationView {
            ZStack {
                if state.showDatePicker {
                    DatePickerView(title: Literals.selectDate,
                                   cancel: Literals.cancel,
                                   accept: Literals.pick,
                                   currentDate: state.searchDate,
                                   minDate: .from(year: 1900, month: 1, day: 1),
                                   maxDate: Date(),
                                   onDismiss: {
                                    store.dispatch(SearchTabAction.hideDatePicker)
                                   },
                                   onDatePicked: { date in
                                    store.dispatch(SearchTabAction.setSearchDate(date))
                                    store.dispatch(SearchTabAction.hideDatePicker)
                                   })
                        .zIndex(1)
                }
                getLoadingView()
                    .opacity(status == .loading ? 1 : 0)
                    .zIndex(1)
                
                switch status {
                case .ready, .loading:
                    getReadyView()
                        .navigationBarHidden(true)
                case .success(let vatTaxpayer):
                    getSuccessView(vatTaxpayer: vatTaxpayer)
                        .navigationBarTitle(vatTaxpayer.name, displayMode: .inline)
                        .navigationBarItems(leading: Button(Literals.back, action: {
                            store.dispatch(SearchTabAction.clearSearch)
                        }))
                        .navigationBarHidden(false)
                case .error(let error):
                    getErrorView(error: error)
                        .navigationBarHidden(true)
                }
            }
        }
    }
    
    private func getReadyView() -> some View {
        VatTaxpayerSearchBar(searchDate: searchDate,
                             searchText: searchText,
                             searchOption: searchOption,
                             error: nil,
                             onSearchTap: search,
                             onDateTap: dateSelection)
    }
    
    private func getLoadingView() -> some View {
        LoadingView(text: Literals.loading)
    }
    
    private func getSuccessView(vatTaxpayer: VatTaxpayer) -> some View {
        VatTaxpayerView(vatTaxpayer: vatTaxpayer)
    }
    
    private func getErrorView(error: VatError) -> some View {
        VatTaxpayerSearchBar(searchDate: searchDate,
                             searchText: searchText,
                             searchOption: searchOption,
                             error: error.localizedMessage,
                             onSearchTap: search,
                             onDateTap: dateSelection)
    }
}

private extension VatError {
    private typealias Literals = MobileAppStrings
    
    var localizedMessage: String {
        switch self {
        case .invalidNip:
            return Literals.invalidNipMessage
        case .invalidRegon:
            return Literals.invalidRegonMessage
        case .invalidAccount:
            return Literals.invalidAccountMessage
        case .noInternetConnection:
            return Literals.noInternetConnection
        case .unknown:
            return Literals.unknownMessage
        }
    }
}

// MARK: - Search bar
extension VatTaxpayerSearchTab {
    
    private var searchDate: Binding<Date> {
        Binding<Date>(get: {
            state.searchDate
        }, set: { date in
            store.dispatch(SearchTabAction.setSearchDate(date))
        })
    }
    
    private var searchText: Binding<String> {
        Binding<String>(get: {
            state.searchQuery
        }, set: { query in
            store.dispatch(SearchTabAction.setSearchQuery(query))
        })
    }
    
    private var searchOption: Binding<VatTaxpayerSearchBar.Option> {
        Binding<VatTaxpayerSearchBar.Option>(get: {
            state.searchOption
        }, set: { option in
            store.dispatch(SearchTabAction.setSearchOption(option))
        })
    }
    
    private func search() {
        switch state.searchOption {
        case .nip:
            store.dispatch(SearchTabAction.searchByNip(state.searchQuery, date: state.searchDate))
        case .regon:
            store.dispatch(SearchTabAction.searchByRegon(state.searchQuery, date: state.searchDate))
        case .account:
            store.dispatch(SearchTabAction.searchByAccount(state.searchQuery, date: state.searchDate))
        }
    }
    
    private func dateSelection() {
        store.dispatch(SearchTabAction.showDatePicker)
    }
}

struct VatTaxpayerSearchTab_Previews: PreviewProvider {
    static var previews: some View {
        VatTaxpayerSearchTab()
    }
}
