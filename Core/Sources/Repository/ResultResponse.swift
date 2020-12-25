//
//  ResultResponse.swift
//  Core
//
//  Created by Mariusz Sut on 06/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

public struct ResultResponse<T: Codable & Equatable> {
    let result: ObjectResult<T>
}

extension ResultResponse: Equatable { /*Nop*/ }

extension ResultResponse: Codable { /*Nop*/ }
