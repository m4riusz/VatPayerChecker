//
//  LoadingView.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 27/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    private typealias Literals = VatPayerCheckerStrings
    
    var body: some View {
        ProgressView(Literals.loading)
            .progressViewStyle(CircularProgressViewStyle())
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
