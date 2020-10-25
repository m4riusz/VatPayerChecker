//
//  CoreAssembly.swift
//  VatPayerChecker
//
//  Created by Mariusz Sut on 25/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Swinject
import Core

final class CoreAssembly: Assembly {
    enum ServiceName: String {
        case localDataSource = "VatPayerCheckerDataSourceProtocolLocal"
        case remoteDataSource = "VatPayerCheckerDataSourceProtocolRemote"
    }
    
    func register(container: Container) {
        registerBasic(container: container)
        registerRepository(container: container)
        
    }
    
    private func registerBasic(container: Container) {
        container.register(JSONDecoder.self) { _ in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.yearMonthDay)
            return decoder
        }
        
        container.register(ConfigurationProtocol.self) { _ in
            ProdConfiguration()
        }.inObjectScope(.container)
    }
    
    private func registerRepository(container: Container) {
        container.register(VatPayerCheckerDataSourceProtocol.self, name: ServiceName.localDataSource.rawValue) { _ in
            LocalVatPayerCheckerDataSource()
        }
        
        container.register(VatPayerCheckerDataSourceProtocol.self, name: ServiceName.remoteDataSource.rawValue) { r in
            RemoteVatPayerCheckerDataSource(configuration: r.resolve(ConfigurationProtocol.self)!,
                                            decoder: r.resolve(JSONDecoder.self)!)
        }
        container.register(VatPayerCheckerRepositoryProtocol.self) { r in
            VatPayerCheckerRepository(local: r.resolve(VatPayerCheckerDataSourceProtocol.self,
                                                       name: ServiceName.localDataSource.rawValue)!,
                                      remote: r.resolve(VatPayerCheckerDataSourceProtocol.self,
                                                        name: ServiceName.remoteDataSource.rawValue)!)
        }
    }
}
