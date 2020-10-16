//
//  ObjectResult.swift
//  Core
//
//  Created by Mariusz Sut on 11/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

public struct ObjectResult<T: Codable> {
    let subject: T
    let requestDateTime: String
    let requestId: String
}

extension ObjectResult: Codable {}
