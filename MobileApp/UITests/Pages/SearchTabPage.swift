//
//  SearchTabPage.swift
//  MobileAppUITests
//
//  Created by Mariusz Sut on 09/01/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation
import TestKit
import XCTest

final class SearchTabPage: Page, Apperance {
    let element: XCUIElement
    
    init(element: XCUIElement) {
        self.element = element
    }
    
}
