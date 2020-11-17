//
//  Middleware.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Combine

typealias Middleware<State, Action> = (State, Action) -> AnyPublisher<Action, Never>?
