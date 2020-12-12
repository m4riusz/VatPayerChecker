//
//  MobileAppAssembly.swift
//  MobileApp
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Swinject
import Core

final class MobileAppAssembly: Assembly {
    
    enum ServiceName: String {
        case searchTabMiddleware
    }
    
    func register(container: Container) {
        registerStates(container: container)
        registerMiddlewares(container: container)
        registerAppStore(container: container)
    }
    
    private func registerStates(container: Container) {
        container.register(SearchTabState.self) { _ in
            SearchTabState()
        }
        
        container.register(MainState.self) { _ in
            MainState()
        }
        
        container.register(AppState.self) { r in
            AppState(mainState: r.resolve(MainState.self)!,
                     searchTabState: r.resolve(SearchTabState.self)!)
        }
    }
    
    private func registerMiddlewares(container: Container) {
        container.register(Middleware<AppState, Action>.self, name: ServiceName.searchTabMiddleware.rawValue) { _ in
            SearchTabMiddleware(repository: container.resolve(VatPayerCheckerRepositoryProtocol.self)!).middleware()
        }
    }
    
    private func registerAppStore(container: Container) {
        container.register(AppStore.self) { r in
            AppStore(initialState: r.resolve(AppState.self)!,
                     reducer: AppReducer.reduce,
                     middlewares: [
                        r.resolve(Middleware<AppState, Action>.self, name: ServiceName.searchTabMiddleware.rawValue)!
                     ])
        }
    }
}
