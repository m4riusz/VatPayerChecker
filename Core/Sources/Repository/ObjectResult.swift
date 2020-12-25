//
//  ObjectResult.swift
//  Core
//
//  Created by Mariusz Sut on 11/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

public struct ObjectResult<T: Codable & Equatable> {
    public let subject: T
    public let requestDateTime: String
    public let requestId: String
}

extension ObjectResult: Equatable { /*Nop*/ }

extension ObjectResult: Codable { /*Nop*/ }
