//
//  MainView.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 08/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var store: AppStore
    
    private var state: MainState {
        store.state.mainState
    }
    
    private var tabBinding: Binding<Tab> {
        Binding<Tab>(get: { state.tab },
                     set: { tab in
                        switch tab {
                        case .vatTaxpayer:
                            store.dispatch(MainAction.openVatTaxpayerTab)
                        case .about:
                            store.dispatch(MainAction.openAboutTab)
                        }})
    }
    
    var body: some View {
        TabView(selection: tabBinding) {
            VatTaxpayerView()
                .tabItem { TabViewItem(title: "Search", image: state.tab == .vatTaxpayer ? "magnifyingglass.circle.fill" : "magnifyingglass.circle") }
                .tag(Tab.vatTaxpayer)
            Text("About")
                .tabItem { TabViewItem(title: "About", image: state.tab == .about ? "info.circle.fill" : "info.circle") }
                .tag(Tab.about)
        }
    }
}

extension MainView {
    enum Tab {
        case vatTaxpayer
        case about
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
