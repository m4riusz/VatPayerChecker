//
//  VatStatusTests.swift
//  CoreTests
//
//  Created by Mariusz Sut on 03/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import XCTest
import TestKit

@testable import Core

final class VatStatusTests: BaseTestCase {
    
    func testDeserializeActive() {
        let sut = decodeFromJsonFile(type: VatStatus.self, fileName: "VatStatus_active")!
        XCTAssertEqual(sut, .active)
    }
    
    func testDeserializeExempt() {
        let sut = decodeFromJsonFile(type: VatStatus.self, fileName: "VatStatus_exempt")!
        XCTAssertEqual(sut, .exempt)
    }
    
    func testDeserializeNotRegistered() {
        let sut = decodeFromJsonFile(type: VatStatus.self, fileName: "VatStatus_notRegistered")!
        XCTAssertEqual(sut, .notRegistered)
    }
    
    func testDeserializeUnknown() {
        let sut = decodeFromJsonFile(type: VatStatus.self, fileName: "VatStatus_unknown")
        XCTAssertNil(sut)
    }
}
