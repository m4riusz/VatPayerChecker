//
//  Assembly.swift
//  MobileApp
//
//  Created by Mariusz Sut on 25/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Swinject
import Core

protocol Assembly {
    func register(container: Container, launchConfiguration: LaunchConfiguration)
}
