//
//  MainView.swift
//  MobileApp
//
//  Created by Mariusz Sut on 08/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import SFSafeSymbols

struct MainView: View {
    private typealias Images = SFSymbol
    private typealias Literals = MobileAppStrings
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
            VatTaxpayerSearchTab()
                .tabItem { searchItem }
                .tag(Tab.vatTaxpayer)
            AboutView()
                .tabItem { aboutItem }
                .tag(Tab.about)
            
        }
        .onAppear { store.dispatch(AboutAction.load) }
    }
    
    private var searchItem: TabViewItem {
        TabViewItem(title: Literals.mainViewSearch,
                    image: state.tab == .vatTaxpayer ? Images.magnifyingglassCircleFill : Images.magnifyingglassCircle)
    }
    
    private var aboutItem: TabViewItem {
        TabViewItem(title: Literals.mainViewAbout,
                    image: state.tab == .about ? Images.infoCircleFill : Images.infoCircle)
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
