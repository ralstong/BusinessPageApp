//
//  DateExtension.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/23/24.
//

import Foundation

extension Date {
    
    /// Returns a simplified string representation of the time
    /// For eg. 8AM, 12:30PM, 8am, 12:30pm, etc.
    /// - Parameters:
    ///   - isUppercased: determines if the am or pm symbol should be uppercased
    /// - Returns: The simplified time string
    func simplifyTimeFromHMS(isUppercased: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Calendar.current.component(.minute, from: self) == 0 ? "ha" : "h:ma"
        dateFormatter.amSymbol = isUppercased ? "AM" : "am"
        dateFormatter.pmSymbol = isUppercased ? "PM" : "pm"
        return dateFormatter.string(from: self)
    }
    
    /// Returns the current day of the week. For eg. Sunday, Monday, etc.
    /// - Returns: The day of the week as a string
    func weekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    /// Returns the date within the current week for the given weekday and time.
    /// - Parameters:
    ///   - weekday: The abbreviated weekday string (e.g., "Mon", "Tue").
    ///   - time: The time string in the format "HH:mm:ss".
    /// - Returns: The date object within the current week for the given weekday and time.
    func dateFrom(weekday: String, time: String) -> Date? {
        let timeAt24 = "24:00:00"
        let timeAt0 = "00:00:00"
        
        var time = time
        var is24Hr = false
        
        // Get Date from time String
        if time == timeAt24 {
            time = timeAt0
            is24Hr = true
        }
        guard let timeDate = time.dateFromHMSTime() else {
            return nil
        }
        
        // Extract hour, minute, and second components from the parsed time
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: timeDate)
        
        // Get the current date and the start of the current week (Monday)
        var startOfWeek: Date = self
        var interval: TimeInterval = 0
        if calendar.dateInterval(of: .weekOfYear, start: &startOfWeek, interval: &interval, for: self) {
            // Adjust to start of week (Monday)
            startOfWeek = calendar.date(byAdding: .day, value: 1, to: startOfWeek) ?? self
        }
        
        // Get the weekday index for the given weekday string
        let weekdaySymbols = calendar.weekdaySymbols
        guard let weekdayIndex = weekdaySymbols.firstIndex(of: weekday.capitalized) else {
            return nil
        }
        
        // Calculate the target date for the given weekday and time
        var daysToAdd = (weekdayIndex + 1) == 8 ? 1 : weekdayIndex + 1
        if is24Hr { daysToAdd = (weekdayIndex + 1) == 8 ? 1 : weekdayIndex + 1 }
        
        var components = DateComponents()
        components.weekday = daysToAdd
        components.hour = timeComponents.hour
        components.minute = timeComponents.minute
        components.second = timeComponents.second
        
        // Calculate the final date
        let targetDate = calendar.nextDate(after: startOfWeek, matching: components, matchingPolicy: .nextTime)
        return targetDate ?? calendar.date(bySettingHour: timeComponents.hour ?? 0,
                                           minute: timeComponents.minute ?? 0,
                                           second: timeComponents.second ?? 0, 
                                           of: self)
    }
    
    /// Returns the subsequent date to meet the given time string from the current date
    /// - Parameters:
    ///   - time: The time string in the format "HH:mm:ss".
    /// - Returns: The date object within the current week for the given weekday and time.
    func nextDate(to time: String) -> Date? {
        let calendar = Calendar.current
        let timeAt24 = "24:00:00"
        let timeAt0 = "00:00:00"
        var time = time
        
        // if 24:00:00, then set to 00:00:00 for format validity
        if time == timeAt24 {
            time = timeAt0
        }
        guard let timeDate = time.dateFromHMSTime() else {
            return nil
        }
        
        // extract the hour, minute, and second components from the timeDate
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: timeDate)
        
        // extract the year, month, and day components from self Date
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        
        // set the hour, minute, and second components to the dateComponents
        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute
        dateComponents.second = timeComponents.second
        
        // create a new Date object with the combined date and time components
        guard let resultDate = calendar.date(from: dateComponents) else {
            return nil
        }
        
        // if the created date is earlier than or equal to the given date's time, add 1 day
        if resultDate <= self {
            return calendar.date(byAdding: .day, value: 1, to: resultDate)
        }
        return resultDate
    }

}
