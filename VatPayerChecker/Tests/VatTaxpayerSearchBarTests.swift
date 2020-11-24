//
//  VatTaxpayerSearchBarTests.swift
//  VatPayerCheckerTests
//
//  Created by Mariusz Sut on 24/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import TestKit
import SwiftUI
import SnapshotTesting

@testable import VatPayerChecker

final class VatTaxpayerSearchBarTests: BaseTestCase {
    private var date = Date()
    private var text = ""
    private var option = VatTaxpayerSearchBar.Option.nip
    private lazy var sut =  Container(view: VatTaxpayerSearchBar(searchDate: Binding(getOnly: date),
                                                                 searchText: Binding(getOnly: text),
                                                                 searchOption: Binding(getOnly: option),
                                                                 onSearchTap: { /*Nop*/ },
                                                                 onDateTap: { /*Nop*/ }),
                                      width: 400,
                                      height: 90)
    
    func testNoClearButton() {
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testClearButton() {
        text = "Some text"
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testNipPlaceholder() {
        option = .nip
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testRegonPlaceholder() {
        option = .regon
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testAccountNumberPlaceholder() {
        option = .account
        assertSnapshot(matching: sut, as: .image)
    }
}
