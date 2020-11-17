//
//  VatTaxpayerAssembly.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Swinject
import Core

final class VatTaxpayerAssembly: Assembly {
    
    enum ServiceName: String {
        case vatTaxpayerMiddleware
    }
    
    func register(container: Container) {
        registerStates(container: container)
        registerMiddlewares(container: container)
        registerAppStore(container: container)
    }
    
    private func registerStates(container: Container) {
        container.register(VatTaxpayerSearchState.self) { _ in
            VatTaxpayerSearchState()
        }
        
        container.register(MainState.self) { _ in
            MainState()
        }
        
        container.register(AppState.self) { r in
            AppState(mainState: r.resolve(MainState.self)!,
                     vatTaxpayerState: r.resolve(VatTaxpayerSearchState.self)!)
        }
    }
    
    private func registerMiddlewares(container: Container) {
        container.register(Middleware<AppState, Action>.self, name: ServiceName.vatTaxpayerMiddleware.rawValue) { _ in
            VatTaxpayerMiddleware(repository: container.resolve(VatPayerCheckerRepositoryProtocol.self)!).middleware()
        }
    }
    
    private func registerAppStore(container: Container) {
        container.register(AppStore.self) { r in
            AppStore(initialState: r.resolve(AppState.self)!,
                     reducer: AppReducer.reduce,
                     middlewares: [
                        r.resolve(Middleware<AppState, Action>.self, name: ServiceName.vatTaxpayerMiddleware.rawValue)!
                     ])
        }
    }
}
