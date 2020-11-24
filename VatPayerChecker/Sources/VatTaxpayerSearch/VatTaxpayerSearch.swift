//
//  VatTaxpayerSearch.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Combine
import Core

struct VatTaxpayerSearch: View {
    @EnvironmentObject var store: AppStore
    private var state: VatTaxpayerSearchState {
        store.state.vatTaxpayerState
    }
    
    var body: some View {
        getByState(status: state.status)
    }
    
    private func getByState(status: VatTaxpayerLoadable) -> AnyView {
        switch status {
        case .ready:
            return AnyView(getReadyView())
        case .loading:
            return AnyView(getLoadingView())
        case .success(let vatTaxpayer):
            return AnyView(getSuccessView(vatTaxpayer: vatTaxpayer))
        case .error(let error):
            return AnyView(getErrorView(error: error))
        }
    }
    
    private func getReadyView() -> some View {
        VStack {
            VatTaxpayerSearchBar(searchText: searchText,
                                 searchOption: searchOption,
                                 onSearchTap: search)
            Button("asasfasa") {
                //TODO
            }
        }
    }
    
    private func getLoadingView() -> some View {
        Text("Loading")
    }
    
    private func getSuccessView(vatTaxpayer: VatTaxpayer) -> some View {
        VStack {
            VatTaxpayerSearchBar(searchText: searchText,
                                 searchOption: searchOption,
                                 onSearchTap: search)
            VatTaxpayerView(vatTaxpayer: vatTaxpayer)
        }
    }
    
    private func getErrorView(error: VatError) -> some View {
        VStack {
            VatTaxpayerSearchBar(searchText: searchText,
                                 searchOption: searchOption,
                                 onSearchTap: search)
            Text("Error")
        }
    }
}

// MARK: - Search bar
extension VatTaxpayerSearch {
    private var searchText: Binding<String> {
        Binding<String>(get: {
            state.searchQuery
        }, set: { query in
            store.dispatch(VatTaxpayerAction.setSearchQuery(query))
        })
    }
    
    private var searchOption: Binding<VatTaxpayerSearchBar.Option> {
        Binding<VatTaxpayerSearchBar.Option>(get: {
            state.searchOption
        }, set: { option in
            store.dispatch(VatTaxpayerAction.setSearchOption(option))
        })
    }
    
    private func search() {
        switch state.searchOption {
        case .nip:
            store.dispatch(VatTaxpayerAction.searchByNip(state.searchQuery, date: state.searchDate))
        case .regon:
            store.dispatch(VatTaxpayerAction.searchByRegon(state.searchQuery, date: state.searchDate))
        case .account:
            store.dispatch(VatTaxpayerAction.searchByAccount(state.searchQuery, date: state.searchDate))
        }
    }
}

struct VatTaxpayerSearch_Previews: PreviewProvider {
    static var previews: some View {
        VatTaxpayerSearch()
    }
}
