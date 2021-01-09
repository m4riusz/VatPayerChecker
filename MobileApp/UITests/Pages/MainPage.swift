//
//  MainPage.swift
//  MobileAppUITests
//
//  Created by Mariusz Sut on 09/01/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation
import TestKit
import XCTest

final class MainPage: Page, Apperance {
    lazy var element: XCUIElement = XCUIApplication()
    
    private var tabbar: XCUIElement {
        element.tabBars.firstMatch
    }
    
    private var searchTabButton: XCUIElement {
        tabbar.buttons.element(boundBy: 0)
    }
    
    private var aboutTabButton: XCUIElement {
        tabbar.buttons.element(boundBy: 1)
    }
    
    func openSearchTab() -> SearchTabPage {
        searchTabButton.tap()
        return SearchTabPage(element: element)
            .waitForApperance()
    }
    
    func openAboutTab() -> AboutTabPage {
        aboutTabButton.tap()
        return AboutTabPage(element: element)
            .waitForApperance()
    }
}
