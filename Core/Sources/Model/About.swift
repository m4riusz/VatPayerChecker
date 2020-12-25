//
//  About.swift
//  Core
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

public struct About {
    public let apiDescription: String
    public let apiUrl: String
    public let usedLibraries: [Library]
}

extension About: Equatable { /*Nop*/ }
