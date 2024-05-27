//
//  DateExtension.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/23/24.
//

import Foundation

extension Date {
    
    func simplifyTimeFromHMS(isUppercased: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Calendar.current.component(.minute, from: self) == 0 ? "ha" : "h:ma"
        dateFormatter.amSymbol = isUppercased ? "AM" : "am"
        dateFormatter.pmSymbol = isUppercased ? "PM" : "pm"
        return dateFormatter.string(from: self)
    }
    
    func dateFromTimeString() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let str = dateFormatter.string(from: self)
        return dateFormatter.date(from: str)
    }
    
    func timeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    func weekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: Date())
    }
    
    func convertToWeekdayFullForm(from shortForm: String) -> String? {
        let short = shortForm.uppercased()
        let inputDF = DateFormatter()
        
        inputDF.dateFormat = "EEE"
        guard let inputDate = inputDF.date(from: short) else {
            return nil
        }
        return inputDate.weekday()
    }
}


extension Date {
    
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
        let daysToAdd = (weekdayIndex + 1) % 7 // Adjust for Monday as the first day
        var components = DateComponents()
        components.weekday = daysToAdd + (is24Hr ? 1 : 0)
        components.hour = timeComponents.hour
        components.minute = timeComponents.minute
        components.second = timeComponents.second
        
        // Calculate the final date
        let targetDate = calendar.nextDate(after: startOfWeek, matching: components, matchingPolicy: .nextTime)
        
        return targetDate ?? calendar.date(bySettingHour: timeComponents.hour ?? 0, minute: timeComponents.minute ?? 0, second: timeComponents.second ?? 0, of: self)
    }
}
