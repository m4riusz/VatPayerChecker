//
//  BindingExtension.swift
//  VatPayerCheckerTests
//
//  Created by Mariusz Sut on 24/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import SwiftUI

extension Binding {
    init(getOnly: Value) {
        self.init(get: { getOnly}, set: { _ in })
    }
}
