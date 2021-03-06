//
//  AnalyticsAction.swift
//  MobileApp
//
//  Created by Mariusz Sut on 05/03/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation
import Core

enum AnalyticsAction: Action {
    case event(_ event: AnalyticsEvent)
}

extension AnalyticsAction: Equatable { /*Nop*/ }
