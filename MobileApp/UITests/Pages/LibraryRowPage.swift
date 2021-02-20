//
//  LibraryRowPage.swift
//  MobileAppUITests
//
//  Created by Mariusz Sut on 09/01/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation
import TestKit
import XCTest

final class LibraryRowPage: Page, Apperance {
    private struct Identifiers {
        static let name = "NameIdentifier"
        static let url = "UrlIdentifier"
        static let license = "LicenseIdentifier"
    }
    
    let element: XCUIElement
    
    init(element: XCUIElement) {
        self.element = element
    }
    
    var name: String {
        nameElement.label
    }
    
    var url: String {
        urlElement.label
    }
    
    var license: String {
        licenseElement.label
    }
    
    private var nameElement: XCUIElement {
        element.staticTexts[Identifiers.name].firstMatch
    }
    
    private var urlElement: XCUIElement {
        element.staticTexts[Identifiers.url].firstMatch
    }
    
    private var licenseElement: XCUIElement {
        element.staticTexts[Identifiers.license].firstMatch
    }
}
