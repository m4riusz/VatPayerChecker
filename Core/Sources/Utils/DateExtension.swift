//
//  DateExtension.swift
//  Core
//
//  Created by Mariusz Sut on 04/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

extension Date {
    
    public static var now: Date {
        Date()
    }
    
    public static func from(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents)!
    }
    
    public var yyyyMMdd: String {
        DateFormatter.yearMonthDay.string(from: self)
    }
}
