//
//  LaunchConfiguration.swift
//  Core
//
//  Created by Mariusz Sut on 06/02/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation

struct EnvironmentKeys {
    static let dev = "Dev"
    static let consoleLog = "ConsoleLog"
}

public struct LaunchConfiguration {
    public let isRunningDev: Bool
    public let consoleLog: Bool
    
    public init(environment: [String: String]) {
        self.isRunningDev = environment[EnvironmentKeys.dev] == "YES"
        self.consoleLog = environment[EnvironmentKeys.consoleLog] == "YES"
    }
}
