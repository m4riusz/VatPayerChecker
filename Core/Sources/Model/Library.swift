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
    public let license: String
    
    public init(name: String, url: String, license: String) {
        self.name = name
        self.url = url
        self.license = license
    }
}

extension Library: Equatable { /*Nop*/ }

extension Library: Hashable { /*Nop*/ }
