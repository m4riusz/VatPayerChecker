//
//  CertificateValidator.swift
//  MobileApp
//
//  Created by Mariusz Sut on 28/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

final class CertificateValidator: NSObject, URLSessionDelegate {
    private let certificateProvider: CertificateProviderProtocol
    
    init(certificateProvider: CertificateProviderProtocol) {
        self.certificateProvider = certificateProvider
    }
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        evaluate(challenge: challenge, completionHandler: completionHandler)
    }
    
    private func evaluate(challenge: URLAuthenticationChallenge,
                          completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if let credential = credentialIfTrustedCertificate(for: challenge) {
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
    
    public func credentialIfTrustedCertificate(for challenge: URLAuthenticationChallenge) -> URLCredential? {
        let protectionSpace = challenge.protectionSpace
        guard protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
              let serverTrust = protectionSpace.serverTrust else {
            return nil
        }
        SecTrustSetAnchorCertificates(serverTrust, [certificateProvider.certificate] as CFArray)
        SecTrustSetAnchorCertificatesOnly(serverTrust, true)
        
        var result: CFError?
        let status = SecTrustEvaluateWithError(serverTrust, &result)
        if let error = result {
            print(error)
        }
        return status ? URLCredential(trust: serverTrust) : nil
    }
}
