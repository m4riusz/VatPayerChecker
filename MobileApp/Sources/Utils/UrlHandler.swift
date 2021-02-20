//
//  UrlHandler.swift
//  MobileApp
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import UIKit
import Core

protocol UrlHandlerProtocol {
    func openUrl(_ url: String)
}

struct UIApplicationUrlHandler: UrlHandlerProtocol {
    private let debugLogger: DebugLogger
    
    public init(debugLogger: DebugLogger) {
        self.debugLogger = debugLogger
    }
    
    func openUrl(_ stringUrl: String) {
        guard let url = URL(string: stringUrl), UIApplication.shared.canOpenURL(url) else {
            debugLogger.error("Unable to open url: \(stringUrl)")
            return
        }
        UIApplication.shared.open(url, options: [:])
        debugLogger.info("Did open url: \(url)")
    }
}
