//
//  Store.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 11/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import SwiftUI

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State

    private let reducer: Reducer<State, Action>

    init(initialState: State, reducer: @escaping Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }

    func dispatch(_ action: Action) {
        state = reducer(state, action)
    }
}
