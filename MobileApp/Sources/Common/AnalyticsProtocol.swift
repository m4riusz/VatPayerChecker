//
//  AnalyticsProtocol.swift
//  MobileApp
//
//  Created by Mariusz Sut on 05/03/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Core
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

protocol AnalyticsProtocol {
    func log(event: AnalyticsEvent)
}

final class AppCenterAnalytics: AnalyticsProtocol {
    
    init(launchConfiguration: LaunchConfiguration) {
        AppCenter.start(withAppSecret: launchConfiguration.appCenterSecret, services: [
            Analytics.self,
            Crashes.self
        ])
    }
    
    func log(event: AnalyticsEvent) {
        Analytics.trackEvent(event.name, withProperties: event.parameters)
    }
}

final class MockAnalytics: AnalyticsProtocol {
    func log(event: AnalyticsEvent) {
        print("event: \(event.name), properties: \(event.parameters ?? [:])")
    }
}
