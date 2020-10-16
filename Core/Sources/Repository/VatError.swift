//
//  VatError.swift
//  Core
//
//  Created by Mariusz Sut on 10/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

public enum VatError: String {
    case unknown
    case noInternetConnection
    case invalidNip = "WL-115"
    case invalidAccount = "WL-111"
    case invalidRegon = "WL-107"
}

extension VatError: Error {}

extension VatError: Codable {}
