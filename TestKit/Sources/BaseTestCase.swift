//
//  BaseTestCase.swift
//  TestKit
//
//  Created by Mariusz Sut on 03/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import XCTest

open class BaseTestCase: XCTestCase {
    
    open var decoder: JSONDecoder {
        JSONDecoder()
    }
    
    open var bundle: Bundle {
        Bundle(for: Self.self)
    }
    
    open func dataFromFile(_ fileName: String, type: String) -> Data? {
        guard let path = bundle.path(forResource: fileName, ofType: type) else {
            return nil
        }
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
    
    open func decodeFromJsonFile<T: Decodable>(type: T.Type, fileName: String) -> T? {
        try? decoder.decode(type, from: dataFromFile(fileName, type: "json")!)
    }
}
