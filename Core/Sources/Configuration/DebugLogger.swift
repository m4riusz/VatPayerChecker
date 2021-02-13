//
//  DebugLogger.swift
//  Core
//
//  Created by Mariusz Sut on 13/02/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation

public protocol DebugLogger {
    func info(_ any: Any, file: String, function: String)
    func error(_ any: Any, file: String, function: String)
    func verbose(_ any: Any, file: String, function: String)
    func rawLog(_ text: String)
}

extension DebugLogger {
    public func info(_ any: Any, file: String = #file, function: String = #function) {
        rawLog("[INFO] [\((file as NSString).lastPathComponent)] [\(function)]: \(any)")
    }
    
    public func error(_ any: Any, file: String = #file, function: String = #function) {
        rawLog("[ERROR] [\((file as NSString).lastPathComponent)] [\(function)]: \(any)")
    }
    
    public func verbose(_ any: Any, file: String = #file, function: String = #function) {
        rawLog("[VERBOSE] [\((file as NSString).lastPathComponent)] [\(function)]: \(any)")
    }
}

public final class MockLogger: DebugLogger {
    public init() { /*Nop*/ }
    public func rawLog(_ text: String) { /*Nop*/ }
}

public final class ConsoleLogger: DebugLogger {
    public init() { /*Nop*/ }
    public func rawLog(_ text: String) { print(text) }
}
