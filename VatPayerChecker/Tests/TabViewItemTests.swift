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
    
    func testNormal() {
        let sut = Container(view: TabViewItem(title: "Play", image: "play.circle"))
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testNoTitle() {
        let sut = Container(view: TabViewItem(title: "", image: "play.circle"))
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testTooLongTitle() {
        let sut = Container(view: TabViewItem(title: "Very very very long title", image: "play.circle"))
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testNoImage() {
        let sut = Container(view: TabViewItem(title: "Play", image: ""))
        assertSnapshot(matching: sut, as: .image)
    }
}
