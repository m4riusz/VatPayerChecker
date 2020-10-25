//
//  VatPayerCheckerApp.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 25/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

@main
struct VatPayerCheckerApp: App {
    
    init() {
        VatPayerCheckerAssembler().assembly()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
