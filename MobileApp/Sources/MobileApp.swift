//
//  MobileApp.swift
//  MobileApp
//
//  Created by Mariusz Sut on 25/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Swinject
import Core

@main
struct MobileApp: App {
    private let container = MobileAppAssembler(
        launchConfiguration: LaunchConfiguration(environment: ProcessInfo().environment))
        .assembly()
    private var store: AppStore {
        container.resolve(AppStore.self)!
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
