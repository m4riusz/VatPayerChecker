//
//  AnalyticsProtocol.swift
//  MobileApp
//
//  Created by Mariusz Sut on 05/03/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation
import AppCenterAnalytics

protocol AnalyticsProtocol {
    func log(event: String, properties: [String: String]?)
}

final class AppCenterAnalytics: AnalyticsProtocol {
    
    func log(event: String, properties: [String : String]?) {
        Analytics.trackEvent("", withProperties: EventProperties())
        print("event: \(event)")
    }
}

final class MockAnalytics: AnalyticsProtocol {
    func log(event: String, properties: [String : String]?) {
        print("event: \(event), properties: \(properties ?? [:])")
    }
}
