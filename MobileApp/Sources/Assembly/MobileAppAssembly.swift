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
        case urlHandler
        case aboutTabMiddleware
        case searchTabMiddleware
    }
    
    func register(container: Container) {
        registerDateProvider(container: container)
        registerUrlHandler(container: container)
        registerStates(container: container)
        registerMiddlewares(container: container)
        registerAppStore(container: container)
    }
    
    private func registerDateProvider(container: Container) {
        container.register(DateProviderProtocol.self) { _ in
            DateProvider()
        }.inObjectScope(.container)
    }
    
    private func registerUrlHandler(container: Container) {
        container.register(UrlHandlerProtocol.self) { _ in
            UIApplicationUrlHandler()
        }.inObjectScope(.container)
    }
    
    private func registerStates(container: Container) {
        container.register(AboutTabState.self) { _ in
            AboutTabState(status: .ready)
        }
        
        container.register(SearchTabState.self) { r in
            SearchTabState(searchQuery: "",
                           searchDate: r.resolve(DateProviderProtocol.self)!.now,
                           showDatePicker: false,
                           searchOption: .nip,
                           status: .ready)
        }
        
        container.register(MainState.self) { _ in
            MainState(tab: .vatTaxpayer)
        }
        
        container.register(AppState.self) { r in
            AppState(mainState: r.resolve(MainState.self)!,
                     searchTabState: r.resolve(SearchTabState.self)!,
                     aboutTabState: r.resolve(AboutTabState.self)!)
        }
    }
    
    private func registerMiddlewares(container: Container) {
        container.register(Middleware<AppState, Action>.self, name: ServiceName.searchTabMiddleware.rawValue) { _ in
            SearchTabMiddleware(repository: container.resolve(VatPayerCheckerRepositoryProtocol.self)!).middleware()
        }
        container.register(Middleware<AppState, Action>.self, name: ServiceName.aboutTabMiddleware.rawValue) { _ in
            AboutTabMiddleware(repository: container.resolve(AboutRepositoryProtocol.self)!).middleware()
        }
        container.register(Middleware<AppState, Action>.self, name: ServiceName.urlHandler.rawValue) { r in
            UrlHandlerMiddleware(urlHandler: r.resolve(UrlHandlerProtocol.self)!).middleware()
        }
    }
    
    private func registerAppStore(container: Container) {
        container.register(AppStore.self) { r in
            AppStore(initialState: r.resolve(AppState.self)!,
                     reducer: AppReducer.reduce,
                     middlewares: [
                        r.resolve(Middleware<AppState, Action>.self, name: ServiceName.searchTabMiddleware.rawValue)!,
                        r.resolve(Middleware<AppState, Action>.self, name: ServiceName.aboutTabMiddleware.rawValue)!,
                        r.resolve(Middleware<AppState, Action>.self, name: ServiceName.urlHandler.rawValue)!
                     ])
        }
    }
}
