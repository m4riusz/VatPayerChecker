//
//  Apperance.swift
//  TestKit
//
//  Created by Mariusz Sut on 09/01/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation
import XCTest

public protocol Apperance {
    var element: XCUIElement { get }
    
    @discardableResult
    func waitForApperance() -> Self
    
    @discardableResult
    func waitForApperance(timeout: TimeInterval, error: String) -> Self
}


public extension Apperance {
    
    @discardableResult
    func waitForApperance() -> Self {
        waitForApperance(timeout: 10, error: "Element does not exist")
    }
    
    @discardableResult
    func waitForApperance(timeout: TimeInterval, error: String) -> Self {
        guard element.waitForExistence(timeout: timeout) else {
            XCTFail(error)
            return self
        }
        return self
    }
}
