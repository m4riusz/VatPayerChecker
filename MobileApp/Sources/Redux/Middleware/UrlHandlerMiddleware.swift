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
    
    init(urlHandler: UrlHandlerProtocol) {
        self.urlHandler = urlHandler
    }
    
    func middleware() -> Middleware<AppState, Action> {
        return { _, action in
            guard let action = action as? AppAction else {
                return Empty().eraseToAnyPublisher()
            }
            switch action {
            case .openUrl(let url):
                urlHandler.openUrl(url)
                return Empty().eraseToAnyPublisher()
            }
        }
    }
}
