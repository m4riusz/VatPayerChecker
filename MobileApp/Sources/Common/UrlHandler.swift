//
//  UrlHandler.swift
//  MobileApp
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import UIKit

protocol UrlHandlerProtocol {
    func openUrl(_ url: String)
}

struct UIApplicationUrlHandler: UrlHandlerProtocol {
    func openUrl(_ stringUrl: String) {
        guard let url = URL(string: stringUrl), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:])
    }
}
