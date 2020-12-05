//
//  TabViewItemTests.swift
//  VatPayerCheckerTests
//
//  Created by Mariusz Sut on 14/11/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import TestKit
import SwiftUI
import SnapshotTesting

@testable import VatPayerChecker

final class TabViewItemTests: BaseTestCase {
    private var title = "Info"
    private lazy var sut = Container(view: TabViewItem(title: title, image: .infoCircleFill))
    
    func testNormal() {
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testNoTitle() {
        title = ""
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testTooLongTitle() {
        title = "Very very very long title"
        assertSnapshot(matching: sut, as: .image)
    }
}
