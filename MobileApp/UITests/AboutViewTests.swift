//
//  AboutViewTests.swift
//  MobileAppUITests
//
//  Created by Mariusz Sut on 09/01/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation
import TestKit
import XCTest

final class AboutViewTests: BaseUITestCase {
    
    private struct Constants {
        static let appName = "VatTaxpayerChecker"
        static let apiDescription = "Aplikacja pobiera dane poprzez API wystawione przez Ministerstwo Finansów - Krajową Administracje Skarbową"
        static let apiUrl = "https://www.gov.pl/web/kas/api-wykazu-podatnikow-vat"
        static let aboutOpenSource = "Biblioteki opensource wykorzystywane przez aplikację"
        static let firstLibraryName = "tuist"
        static let firstLibraryUrl = "https://github.com/tuist/tuist"
        static let firstLibraryLicense = "MIT License\n\nCopyright (c) from 2018 Pedro Piñera Buendía\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
    }

    func testHeader() {
        MainPage()
            .waitForApperance()
            .openAboutTab()
            .header
            .inspect { page in
                XCTAssertEqual(page.appName, Constants.appName)
                XCTAssertEqual(page.apiDescription, Constants.apiDescription)
                XCTAssertEqual(page.apiUrl, Constants.apiUrl)
            }
    }
    
    func testLibraries() {
        MainPage()
            .waitForApperance()
            .openAboutTab()
            .inspect { page in
                XCTAssertEqual(page.aboutOpenSource, Constants.aboutOpenSource)
                let firstLibrary = page.libraryCells.first
                XCTAssertEqual(firstLibrary?.name, Constants.firstLibraryName)
                XCTAssertEqual(firstLibrary?.url, Constants.firstLibraryUrl)
                XCTAssertEqual(firstLibrary?.license, Constants.firstLibraryLicense)
            }
    }
}
