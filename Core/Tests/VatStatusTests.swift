//
//  VatStatusTests.swift
//  CoreTests
//
//  Created by Mariusz Sut on 03/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import XCTest

@testable import Core

class BaseTestCase: XCTestCase {
    
    open var bundle: Bundle {
        Bundle(for: Self.self)
    }
    
    open func dataFromFile(_ fileName: String, type: String = "json") -> Data? {
        guard let path = bundle.path(forResource: fileName, ofType: type) else {
            return nil
        }
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
    
    open func decodeFromJsonFile<T: Decodable>(type: T.Type, fileName: String) -> T? {
        try? JSONDecoder().decode(type, from: dataFromFile(fileName)!)
    }
    
}

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
