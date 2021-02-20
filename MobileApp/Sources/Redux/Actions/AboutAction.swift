//
//  AboutAction.swift
//  MobileApp
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Core

enum AboutAction: Action {
    case load
    case setResult(_ result: About)
}

extension AboutAction: Equatable { /*Nop*/ }
