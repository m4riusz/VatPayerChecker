//
//  AboutTabMiddleware.swift
//  MobileApp
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Core
import Combine

struct AboutTabMiddleware {
    private let repository: AboutRepositoryProtocol
    
    init(repository: AboutRepositoryProtocol) {
        self.repository = repository
    }
    
    func middleware() -> Middleware<AppState, Action> {
        return { _, action in
            guard let action = action as? AboutAction else {
                return Empty().eraseToAnyPublisher()
            }
            switch action {
            case .load:
                return repository.getAbout()
                    .map { AboutAction.setResult($0) }
                    .eraseToAnyPublisher()
            case .setResult:
                return Empty().eraseToAnyPublisher()
            }
        }
    }
}
