//
//  CertificateProvider.swift
//  MobileApp
//
//  Created by Mariusz Sut on 28/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Core

protocol CertificateProviderProtocol {
    var certificate: SecCertificate { get }
}

final class CertificateProvider: CertificateProviderProtocol {
    private let configuration: ConfigurationProtocol
    private let bundle: Bundle
    
    init(configuration: ConfigurationProtocol, bundle: Bundle) {
        self.configuration = configuration
        self.bundle = bundle
    }
    
    lazy var certificate: SecCertificate = {
        guard let fileUrl = bundle.url(forResource: configuration.certificate, withExtension: nil),
              let data = try? Data(contentsOf: fileUrl),
              let cerfificate = SecCertificateCreateWithData(nil, data as CFData) else {
            fatalError("Unable to load certificate!")
        }
        return cerfificate
    }()
}
