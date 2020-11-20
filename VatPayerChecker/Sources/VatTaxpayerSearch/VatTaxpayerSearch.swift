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
        getByState(query: state.query, date: state.date, status: state.status)
    }
    
    private func getByState(query: String?, date: Date?, status: VatTaxpayerLoadable) -> AnyView {
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
        Button("asasfasa") {
            //TODO
        }
    }
    
    private func getLoadingView() -> some View {
        Text("Loading")
    }
    
    private func getSuccessView(vatTaxpayer: VatTaxpayer) -> some View {
        VatTaxpayerView(vatTaxpayer: vatTaxpayer)
    }
    
    private func getErrorView(error: VatError) -> some View {
        Text("Error")
    }
}

struct VatTaxpayerSearch_Previews: PreviewProvider {
    static var previews: some View {
        VatTaxpayerSearch()
    }
}
