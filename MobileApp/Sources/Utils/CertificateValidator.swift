//
//  CertificateValidator.swift
//  MobileApp
//
//  Created by Mariusz Sut on 28/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Core

final class CertificateValidator: NSObject, URLSessionDelegate {
    private let certificateProvider: CertificateProviderProtocol
    private let debugLogger: DebugLogger
    
    init(certificateProvider: CertificateProviderProtocol, debugLogger: DebugLogger) {
        self.certificateProvider = certificateProvider
        self.debugLogger = debugLogger
    }
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        evaluate(challenge: challenge, completionHandler: completionHandler)
    }
    
    private func evaluate(challenge: URLAuthenticationChallenge,
                          completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if let credential = credentialIfTrustedCertificate(for: challenge) {
            debugLogger.verbose("Certificate evaluation succeed")
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
    
    public func credentialIfTrustedCertificate(for challenge: URLAuthenticationChallenge) -> URLCredential? {
        let protectionSpace = challenge.protectionSpace
        guard protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
              let serverTrust = protectionSpace.serverTrust else {
            debugLogger.error("Certificate evaluation failed - unknowm method")
            return nil
        }
        SecTrustSetAnchorCertificates(serverTrust, [certificateProvider.certificate] as CFArray)
        SecTrustSetAnchorCertificatesOnly(serverTrust, true)
        
        var result: CFError?
        let status = SecTrustEvaluateWithError(serverTrust, &result)
        if let error = result {
            debugLogger.error("Certificate evaluation failed: \(error)")
        }
        return status ? URLCredential(trust: serverTrust) : nil
    }
}
