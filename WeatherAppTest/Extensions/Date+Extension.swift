//
//  Date+Extension.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/28/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import Foundation

extension Date {
    func dateName() -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "Today"
        }
        else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d"
            return dateFormatter.string(from: self)
        }
    }
}

