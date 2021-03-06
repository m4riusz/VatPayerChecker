//
//  AnalyticsMiddleware.swift
//  MobileApp
//
//  Created by Mariusz Sut on 05/03/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation
import Core
import Combine

struct AnalyticsMiddleware {
    private let analytics: AnalyticsProtocol
    
    init(analytics: AnalyticsProtocol) {
        self.analytics = analytics
    }
    
    func middleware() -> Middleware<AppState, Action> {
        return { _, action in
            guard let action = action as? AnalyticsAction else {
                return Empty().eraseToAnyPublisher()
            }
            switch action {
            case .event(let event):
                analytics.log(event: event)
                return Empty().eraseToAnyPublisher()
            }
        }
    }
}
