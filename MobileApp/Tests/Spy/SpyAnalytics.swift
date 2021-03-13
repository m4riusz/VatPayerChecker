//
//  SpyAnalytics.swift
//  MobileApp
//
//  Created by Mariusz Sut on 06/03/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation

@testable import MobileApp

final class SpyAnalytics: AnalyticsProtocol {
    public private (set) var events: [AnalyticsEvent] = []
    
    func log(event: AnalyticsEvent) {
        events.append(event)
    }
}
