//
//  AboutViewHeaderPage.swift
//  MobileAppUITests
//
//  Created by Mariusz Sut on 09/01/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation
import TestKit
import XCTest

final class AboutViewHeaderPage: Page, Apperance {
    private struct Identifiers {
        static let appName = "AppNameIdentifier"
        static let apiDescription = "ApiDescriptionIdentifier"
        static let apiUrl = "ApiUrlIdentifier"
    }
    
    let element: XCUIElement
    
    init(element: XCUIElement) {
        self.element = element
    }
    
    var apiDescription: String {
        apiDescriptionElement.label
    }
    
    var appName: String {
        appNameElement.label
    }
    
    var apiUrl: String {
        apiUrlElement.label
    }
    
    private var appNameElement: XCUIElement {
        element.staticTexts[Identifiers.appName].firstMatch
    }
    
    private var apiDescriptionElement: XCUIElement {
        element.staticTexts[Identifiers.apiDescription].firstMatch
    }
    
    private var apiUrlElement: XCUIElement {
        element.staticTexts[Identifiers.apiUrl].firstMatch
    }
}
