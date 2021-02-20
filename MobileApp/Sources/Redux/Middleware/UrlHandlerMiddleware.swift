//
//  UrlHandlerMiddleware.swift
//  MobileApp
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Core
import Combine

struct UrlHandlerMiddleware {
    private let urlHandler: UrlHandlerProtocol
    private let debugLogger: DebugLogger
    
    init(urlHandler: UrlHandlerProtocol, debugLogger: DebugLogger) {
        self.urlHandler = urlHandler
        self.debugLogger = debugLogger
    }
    
    func middleware() -> Middleware<AppState, Action> {
        return { _, action in
            guard let action = action as? AppAction else {
                return Empty().eraseToAnyPublisher()
            }
            switch action {
            case .openUrl(let url):
                debugLogger.verbose("Try to open url: \(url)")
                urlHandler.openUrl(url)
                return Empty().eraseToAnyPublisher()
            }
        }
    }
}
