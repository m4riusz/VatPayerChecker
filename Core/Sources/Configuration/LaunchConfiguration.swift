//
//  LaunchConfiguration.swift
//  Core
//
//  Created by Mariusz Sut on 06/02/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import Foundation

public struct LaunchConfiguration {
    public let isRunningDev: Bool
    
    public init(environment: [String: String]) {
        self.isRunningDev = environment["Dev"] == "YES"
    }
}
