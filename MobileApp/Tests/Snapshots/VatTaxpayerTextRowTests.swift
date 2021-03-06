//
//  VatTaxpayerTextRowTests.swift
//  MobileAppTests
//
//  Created by Mariusz Sut on 20/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import TestKit
import SwiftUI
import SnapshotTesting

@testable import MobileApp

final class VatTaxpayerTextRowTests: BaseTestCase {
    private var text = ""
    private var values = [""]
    private var actionText: String?
    private lazy var sut = ListContainer(view: VatTaxpayerTextRow(title: text,
                                                                  values: values,
                                                                  actionButton: actionText,
                                                                  action: { _ in }))
    
    func testSingleLine() {
        text = "Section"
        values = ["Value"]
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testLongLine() {
        text =  "Very long title thas should have multiple lines"
        values = ["Very long description matching multiple lines"]
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testMultipleRows() {
        text =  "Title"
        values = ["Item one", "Item two"]
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testActionRow() {
        text =  "Title"
        values = ["Item one", "Item two"]
        actionText = "Kopiuj"
        assertSnapshot(matching: sut, as: .image)
    }
}
