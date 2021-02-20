//
//  Page.swift
//  TestKit
//
//  Created by Mariusz Sut on 09/01/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation
import XCTest

public protocol Page {
    
    @discardableResult
    func inspect(page : (Self) -> Void) -> Self
}

public extension Page {
    
    @discardableResult
    func inspect(page : (Self) -> Void) -> Self {
        page(self)
        return self
    }
}
