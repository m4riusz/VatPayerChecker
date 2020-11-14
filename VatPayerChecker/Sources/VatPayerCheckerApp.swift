//
//  VatPayerCheckerApp.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 25/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import Swinject
import Core

@main
struct VatPayerCheckerApp: App {
    private let container = VatPayerCheckerAssembler().assembly()
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
