//
//  MainView.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 08/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

struct MainView: View {
    private typealias Images = VatPayerCheckerAsset
    private typealias Literals = VatPayerCheckerStrings
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
            VatTaxpayerSearch()
                .tabItem { searchItem }
                .tag(Tab.vatTaxpayer)
            Text("About")
                .tabItem { aboutItem }
                .tag(Tab.about)
        }
    }
    
    private var searchItem: TabViewItem {
        TabViewItem(title: Literals.mainViewSearch,
                    image: state.tab == .vatTaxpayer ? Images.searchFilled.image : Images.searchOutline.image)
    }
    
    private var aboutItem: TabViewItem {
        TabViewItem(title: Literals.mainViewAbout,
                    image: state.tab == .about ? Images.infoFilled.image : Images.infoOutline.image)
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
