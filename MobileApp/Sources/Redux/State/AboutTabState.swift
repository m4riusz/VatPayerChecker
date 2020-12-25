//
//  AboutTabState.swift
//  MobileApp
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Core

enum AboutTabLoadable {
    case ready
    case loaded(about: About)
}

extension AboutTabLoadable: Equatable { /*Nop*/ }

struct AboutTabState: StateRedux {
    var status: AboutTabLoadable = .ready
}
