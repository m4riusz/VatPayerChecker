//
//  BaseUITestCase.swift
//  TestKit
//
//  Created by Mariusz Sut on 09/01/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation
import XCTest

open class BaseUITestCase: BaseTestCase {
    
    public lazy var application = XCUIApplication()
    
    open override func setUp() {
        continueAfterFailure = true
        application.launch()
        sleep(2)
    }
}
