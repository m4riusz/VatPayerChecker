//
//  AboutDataSourceProtocol.swift
//  Core
//
//  Created by Mariusz Sut on 25/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation
import Combine

public protocol AboutDataSourceProtocol {
    func getAbout() -> Future<About, Never>
}
