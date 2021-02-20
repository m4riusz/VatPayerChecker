//
//  About.swift
//  Core
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

public struct About {
    public let apiUrl: String
    public let usedLibraries: [Library]
    
    public init(apiUrl: String, usedLibraries: [Library]) {
        self.apiUrl = apiUrl
        self.usedLibraries = usedLibraries
    }
}

extension About: Equatable { /*Nop*/ }
