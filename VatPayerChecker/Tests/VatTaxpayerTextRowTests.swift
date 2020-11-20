//
//  VatTaxpayerTextRowTests.swift
//  VatPayerCheckerTests
//
//  Created by Mariusz Sut on 20/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import TestKit
import SwiftUI
import SnapshotTesting

@testable import VatPayerChecker

final class VatTaxpayerTextRowTests: BaseTestCase {
    
    func testSingleLine() {
        let sut = ListContainer(view: VatTaxpayerTextRow(title: "Section", value: "Value"))
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testLongLine() {
        let sut = ListContainer(view: VatTaxpayerTextRow(title: "Very long title thas should have multiple lines",
                                                            value: "Very long description matching multiple lines"))
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testMultipleRows() {
        let sut = ListContainer(view: VatTaxpayerTextRow(title: "Title", values: ["Item one", "Item two"]))
        assertSnapshot(matching: sut, as: .image)
    }
}
