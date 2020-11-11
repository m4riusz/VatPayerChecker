//
//  ContentView.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 25/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI
import ReSwift

struct ContentView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
