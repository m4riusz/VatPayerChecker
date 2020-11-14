//
//  Store.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 11/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    
    private let reducer: Reducer<State, Action>
    private let middlewares: [Middleware<State, Action>]
    private var middlewareCancellables: Set<AnyCancellable> = []
    
    init(initialState: State,
         reducer: @escaping Reducer<State, Action>,
         middlewares: [Middleware<State, Action>]) {
        self.state = initialState
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    func dispatch(_ action: Action) {
        state = reducer(state, action)
        middlewares
            .compactMap { $0(state, action) }
            .forEach { $0
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &middlewareCancellables)
            }
    }
}
