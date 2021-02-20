//
//  LibraryRowTests.swift
//  MobileAppTests
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import TestKit
import SwiftUI
import SnapshotTesting
import Core

@testable import MobileApp

final class LibraryRowTests: BaseTestCase {
    private lazy var libraryName = "Name"
    private lazy var libraryUrl = "http://somelink.com"
    private lazy var libraryLicense = "Some licence"
    private lazy var library = Library(name: libraryName, url: libraryUrl, license: libraryLicense)
    private lazy var sut = ListContainer(view: LibraryRow(library: library, onLinkTap: { /*Nop*/ }))
    
    func testSingleLineName() {
        libraryName = "Short name"
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testMultiLineName() {
        libraryName = "Very long text that should fit multiple lines"
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testSingleLineUrl() {
        libraryUrl = "http://shortlink.com"
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testMultiLineUrl() {
        libraryUrl = "http://verylonglinkthatshouldbreakintomultiplelines.com"
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testSingleLineLicense() {
        libraryLicense = "Short license"
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testMultiLineLicense() {
        libraryLicense = "Very long text that should fit multiple lines"
        assertSnapshot(matching: sut, as: .image)
    }
}
