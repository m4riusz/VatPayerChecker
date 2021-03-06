//
//  AboutView.swift
//  MobileApp
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Core

struct AboutView: View {
    private struct Identifiers {
        static let headerView = "AboutViewHeader"
        static let aboutOpenSource = "AboutOpenSourceLabel"
        static let cellIdentifier = "LibraryCell"
    }
    private typealias Literals = MobileAppStrings
    private typealias Images = MobileAppAsset
    @EnvironmentObject var store: AppStore
    private var state: AboutTabState {
        store.state.aboutTabState
    }
    
    var body: some View {
        getByState(status: state.status)
    }
    
    private func getByState(status: AboutTabLoadable) -> some View {
        NavigationView {
            switch status {
            case .ready:
                Text("")
                    .navigationBarTitle(Literals.mainViewAbout, displayMode: .inline)
            case .loaded(let about):
                getAboutView(about: about)
                    .navigationBarTitle(Literals.mainViewAbout, displayMode: .inline)
            }
        }
    }
    
    private func getAboutView(about: About) -> some View {
        List {
            AboutViewHeader(appName: Literals.appName,
                            apiDescription: Literals.aboutApiDescription,
                            apiUrl: about.apiUrl,
                            onUrlTap: {
                                store.dispatch(AnalyticsAction.event(.urlOpen(.about, about.apiUrl)))
                                store.dispatch(AppAction.openUrl(about.apiUrl))
                            })
                .accessibilityIdentifier(Identifiers.headerView)
            if !about.usedLibraries.isEmpty {
                Text(Literals.aboutOpenSource)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .bottom], 10)
                    .accessibilityIdentifier(Identifiers.aboutOpenSource)
                ForEach(about.usedLibraries, id: \.self) { library in
                    LibraryRow(library: library) {
                        store.dispatch(AnalyticsAction.event(.urlOpen(.about, about.apiUrl)))
                        store.dispatch(AppAction.openUrl(library.url))
                    }
                        .accessibilityIdentifier(Identifiers.cellIdentifier)
                }
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
