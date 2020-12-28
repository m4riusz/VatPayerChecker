//
//  DateProvider.swift
//  MobileApp
//
//  Created by Mariusz Sut on 27/12/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

protocol DateProviderProtocol {
    var now: Date { get }
}

final class DateProvider: DateProviderProtocol {
    var now: Date {
        Date()
    }
}
