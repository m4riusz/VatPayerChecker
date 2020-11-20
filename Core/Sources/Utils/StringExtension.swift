//
//  StringExtension.swift
//  Core
//
//  Created by Mariusz Sut on 20/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    public var isNil: Bool {
        self == nil
    }
    
    public var isNilOrEmpty: Bool {
        isNil || (self?.isEmpty ?? true)
    }
}
