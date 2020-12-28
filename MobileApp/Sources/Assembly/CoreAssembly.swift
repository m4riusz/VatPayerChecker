//
//  CoreAssembly.swift
//  MobileApp
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
        registerNetworking(container: container)
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
    
    private func registerNetworking(container: Container) {
        container.register(CertificateProviderProtocol.self) { r in
            CertificateProvider(configuration: r.resolve(ConfigurationProtocol.self)!,
                                bundle: MobileAppResources.bundle)
        }.inObjectScope(.container)
        
        container.register(URLSessionDelegate.self) { r  in
            CertificateValidator(certificateProvider: r.resolve(CertificateProviderProtocol.self)!)
        }.inObjectScope(.container)
        
        container.register(URLSessionConfiguration.self) { _  in
            let configuration = URLSessionConfiguration.default
            configuration.waitsForConnectivity = false
            return configuration
        }.inObjectScope(.container)
        
        container.register(URLSession.self) { r in
            URLSession(configuration: r.resolve(URLSessionConfiguration.self)!,
                       delegate: r.resolve(URLSessionDelegate.self)!,
                       delegateQueue: nil)
        }.inObjectScope(.container)
    }
    
    private func registerRepository(container: Container) {
        container.register(AboutDataSourceProtocol.self) { _ in
            LocalAboutDataSource()
        }
        
        container.register(VatPayerCheckerDataSourceProtocol.self, name: ServiceName.localDataSource.rawValue) { _ in
            LocalVatPayerCheckerDataSource()
        }
        
        container.register(VatPayerCheckerDataSourceProtocol.self, name: ServiceName.remoteDataSource.rawValue) { r in
            RemoteVatPayerCheckerDataSource(configuration: r.resolve(ConfigurationProtocol.self)!,
                                            session: r.resolve(URLSession.self)!,
                                            decoder: r.resolve(JSONDecoder.self)!)
        }
        
        container.register(AboutRepositoryProtocol.self) { r in
            AboutRepository(local: r.resolve(AboutDataSourceProtocol.self)!)
        }
        
        container.register(VatPayerCheckerRepositoryProtocol.self) { r in
            VatPayerCheckerRepository(local: r.resolve(VatPayerCheckerDataSourceProtocol.self,
                                                       name: ServiceName.localDataSource.rawValue)!,
                                      remote: r.resolve(VatPayerCheckerDataSourceProtocol.self,
                                                        name: ServiceName.remoteDataSource.rawValue)!)
        }
    }
}
