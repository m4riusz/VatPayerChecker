//
//  VatStatus.swift
//  Core
//
//  Created by Mariusz Sut on 03/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

public enum VatStatus: String {
    case active = "Czynny"
    case exempt = "Zwolniony"
    case notRegistered = "Niezarejestrowany"
}

extension VatStatus: Codable {}

extension VatStatus: Equatable {}
