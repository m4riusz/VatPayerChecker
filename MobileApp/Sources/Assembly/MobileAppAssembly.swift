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
import AppCenter

final class MobileAppAssembly: Assembly {
    
    enum ServiceName: String {
        case urlHandler
        case aboutTabMiddleware
        case searchTabMiddleware
        case analyticsMiddleware
    }
    
    func register(container: Container, launchConfiguration: LaunchConfiguration) {
        registerDateProvider(container: container, launchConfiguration: launchConfiguration)
        registerUrlHandler(container: container, launchConfiguration: launchConfiguration)
        registerStates(container: container, launchConfiguration: launchConfiguration)
        registerMiddlewares(container: container, launchConfiguration: launchConfiguration)
        registerAppStore(container: container, launchConfiguration: launchConfiguration)
        registerAnalytics(container: container, launchConfiguration: launchConfiguration)
    }
    
    private func registerAnalytics(container: Container, launchConfiguration: LaunchConfiguration) {
        container.register(AnalyticsProtocol.self) { _ in
            if launchConfiguration.isRunningDev {
                return MockAnalytics()
            }
            return AppCenterAnalytics(launchConfiguration: launchConfiguration)
        }
    }
    
    private func registerDateProvider(container: Container, launchConfiguration: LaunchConfiguration) {
        container.register(DateProviderProtocol.self) { _ in
            DateProvider()
        }.inObjectScope(.container)
    }
    
    private func registerUrlHandler(container: Container, launchConfiguration: LaunchConfiguration) {
        container.register(UrlHandlerProtocol.self) { r in
            UIApplicationUrlHandler(debugLogger: r.resolve(DebugLogger.self)!)
        }.inObjectScope(.container)
    }
    
    private func registerStates(container: Container, launchConfiguration: LaunchConfiguration) {
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
    
    private func registerMiddlewares(container: Container, launchConfiguration: LaunchConfiguration) {
        container.register(Middleware<AppState, Action>.self, name: ServiceName.searchTabMiddleware.rawValue) { r in
            SearchTabMiddleware(repository: r.resolve(VatPayerCheckerRepositoryProtocol.self)!,
                                analytics: r.resolve(AnalyticsProtocol.self)!,
                                debugLogger: r.resolve(DebugLogger.self)!).middleware()
        }
        container.register(Middleware<AppState, Action>.self, name: ServiceName.aboutTabMiddleware.rawValue) { r in
            AboutTabMiddleware(repository: r.resolve(AboutRepositoryProtocol.self)!,
                               debugLogger: r.resolve(DebugLogger.self)!).middleware()
        }
        container.register(Middleware<AppState, Action>.self, name: ServiceName.urlHandler.rawValue) { r in
            UrlHandlerMiddleware(urlHandler: r.resolve(UrlHandlerProtocol.self)!,
                                 debugLogger: r.resolve(DebugLogger.self)!).middleware()
        }
        container.register(Middleware<AppState, Action>.self, name: ServiceName.analyticsMiddleware.rawValue) { r in
            AnalyticsMiddleware(analytics: r.resolve(AnalyticsProtocol.self)!).middleware()
        }
    }
    
    private func registerAppStore(container: Container, launchConfiguration: LaunchConfiguration) {
        container.register(AppStore.self) { r in
            AppStore(initialState: r.resolve(AppState.self)!,
                     reducer: AppReducer.reduce,
                     middlewares: [
                        r.resolve(Middleware<AppState, Action>.self, name: ServiceName.searchTabMiddleware.rawValue)!,
                        r.resolve(Middleware<AppState, Action>.self, name: ServiceName.aboutTabMiddleware.rawValue)!,
                        r.resolve(Middleware<AppState, Action>.self, name: ServiceName.urlHandler.rawValue)!,
                        r.resolve(Middleware<AppState, Action>.self, name: ServiceName.analyticsMiddleware.rawValue)!
                     ])
        }
    }
}
