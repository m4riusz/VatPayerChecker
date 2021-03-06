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
    
    func register(container: Container, launchConfiguration: LaunchConfiguration) {
        registerBasic(container: container, launchConfiguration: launchConfiguration)
        registerRepository(container: container, launchConfiguration: launchConfiguration)
        registerNetworking(container: container, launchConfiguration: launchConfiguration)
    }
    
    private func registerBasic(container: Container, launchConfiguration: LaunchConfiguration) {
        container.register(DebugLogger.self) { _ in
            if launchConfiguration.consoleLog {
                return ConsoleLogger()
            }
            return MockLogger()
        }
        
        container.register(JSONDecoder.self) { _ in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.yearMonthDay)
            return decoder
        }
        
        container.register(ConfigurationProtocol.self) { _ in
            if launchConfiguration.isRunningDev {
                return DevConfiguration()
            }
            return ProdConfiguration()
        }.inObjectScope(.container)
    }
    
    private func registerNetworking(container: Container, launchConfiguration: LaunchConfiguration) {
        container.register(CertificateProviderProtocol.self) { r in
            CertificateProvider(configuration: r.resolve(ConfigurationProtocol.self)!,
                                debugLogger: r.resolve(DebugLogger.self)!,
                                bundle: MobileAppResources.bundle)
        }.inObjectScope(.container)
        
        container.register(URLSessionDelegate?.self) { r  in
            if launchConfiguration.isRunningDev {
                return nil
            }
            return CertificateValidator(certificateProvider: r.resolve(CertificateProviderProtocol.self)!,
                                        debugLogger: r.resolve(DebugLogger.self)!)
        }.inObjectScope(.container)
        
        container.register(URLSessionConfiguration.self) { _  in
            let configuration = URLSessionConfiguration.default
            configuration.waitsForConnectivity = false
            return configuration
        }.inObjectScope(.container)
        
        container.register(URLSession.self) { r in
            URLSession(configuration: r.resolve(URLSessionConfiguration.self)!,
                       delegate: r.resolve(URLSessionDelegate?.self)!,
                       delegateQueue: nil)
        }.inObjectScope(.container)
    }
    
    private func registerRepository(container: Container, launchConfiguration: LaunchConfiguration) {
        container.register(AboutDataSourceProtocol.self) { r in
            LocalAboutDataSource(configuration: r.resolve(ConfigurationProtocol.self)!)
        }
        
        container.register(VatPayerCheckerDataSourceProtocol.self, name: ServiceName.localDataSource.rawValue) { _ in
            LocalVatPayerCheckerDataSource()
        }
        
        container.register(VatPayerCheckerDataSourceProtocol.self, name: ServiceName.remoteDataSource.rawValue) { r in
            RemoteVatPayerCheckerDataSource(configuration: r.resolve(ConfigurationProtocol.self)!,
                                            debugLogger: r.resolve(DebugLogger.self)!,
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
