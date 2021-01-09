//
//  AboutTabPage.swift
//  MobileAppUITests
//
//  Created by Mariusz Sut on 09/01/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation
import TestKit
import XCTest

final class AboutTabPage: Page, Apperance {
    private struct Identifiers {
        static let headerView = "AboutViewHeader"
        static let aboutOpenSource = "AboutOpenSourceLabel"
        static let cellIdentifier = "LibraryCell"
    }
    
    let element: XCUIElement
    
    init(element: XCUIElement) {
        self.element = element
    }
    
    var header: AboutViewHeaderPage {
        AboutViewHeaderPage(element: headerViewElement)
    }
    
    var aboutOpenSource: String {
        aboutOpenSourceElement.label
    }
    
    var libraryCells: [LibraryRowPage] {
        libraryCellElements.map { LibraryRowPage(element: $0) }
    }
    
    private var headerViewElement: XCUIElement {
        element.otherElements[Identifiers.headerView].firstMatch
    }
    
    private var aboutOpenSourceElement: XCUIElement {
        element.staticTexts[Identifiers.aboutOpenSource].firstMatch
    }
    
    private var libraryCellElements: [XCUIElement] {
        element.otherElements.matching(identifier: Identifiers.cellIdentifier).allElementsBoundByIndex
    }
}
