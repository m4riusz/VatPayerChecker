//
//  Library.swift
//  Core
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

public struct Library {
    public let name: String
    public let url: String
    public let licence: String
    
    public init(name: String, url: String, licence: String) {
        self.name = name
        self.url = url
        self.licence = licence
    }
}

extension Library: Equatable { /*Nop*/ }

extension Library: Hashable { /*Nop*/ }
