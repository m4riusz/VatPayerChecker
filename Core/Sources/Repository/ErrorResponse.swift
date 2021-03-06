//
//  ErrorResponse.swift
//  Core
//
//  Created by Mariusz Sut on 10/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

public struct ErrorResponse {
    let code: VatError
    let message: String
}

extension ErrorResponse: Codable {}
