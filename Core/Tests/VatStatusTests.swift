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
        let object = decodeFromJsonFile(type: VatStatus.self, fileName: "VatStatus_active")!
        XCTAssertEqual(object, .active)
    }
    
    func testDeserializeExempt() {
        let object = decodeFromJsonFile(type: VatStatus.self, fileName: "VatStatus_exempt")!
        XCTAssertEqual(object, .exempt)
    }
    
    func testDeserializeNotRegistered() {
        let object = decodeFromJsonFile(type: VatStatus.self, fileName: "VatStatus_notRegistered")!
        XCTAssertEqual(object, .notRegistered)
    }
    
    func testDeserializeUnknown() {
        let object = decodeFromJsonFile(type: VatStatus.self, fileName: "VatStatus_unknown")
        XCTAssertNil(object)
    }
}
