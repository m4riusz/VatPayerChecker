//
//  DateFormatterExtension.swift
//  Core
//
//  Created by Mariusz Sut on 04/10/2020.
//  Copyright © 2020 MSut. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var yearMonthDay: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}
