//
//  DateTimeHelper.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/23/24.
//

import Foundation

struct DateTimeHelper {
    
    static let daysOfTheWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    /// Processes the weekday - TimeInfo array dictionary to simplify and sort time ranges
    /// - Parameters:
    ///   - info: Dictionary containing key as weekday string and value as TimeInfo
    /// - Returns: The simplified dictionary containing key as weekday string and value as TimeInfo sorted by start time
    static func processDateTimes(_ info: [String: [TimeInfo]]) -> [String: [TimeInfo]] {
        return combineOverlappingTimes(sortTimes(info))
    }
    
    /// Sorts TimeInfo values for each weekday by increasing start time
    /// - Parameters:
    ///   - info: Dictionary containing key as weekday string and value as TimeInfo
    /// - Returns: The dictionary containing key as weekday string and value as TimeInfo sorted by start time
    static func sortTimes(_ info: [String: [TimeInfo]]) -> [String: [TimeInfo]] {
        var info = info
        
        for day in daysOfTheWeek {
            guard var time = info[day] else {
                continue
            }
            time.sort(by: { $0.startTime < $1.startTime })
            info[day] = time
        }
        return info
    }
    
    /// Combines overlapping or continuous times where possible across weekdays and within the day
    /// - Parameters:
    ///   - sortedInfo: Dictionary containing key as weekday string and value as TimeInfo sorted by start time
    /// - Returns: The simplified dictionary containing key as weekday string and value as TimeInfo
    static func combineOverlappingTimes(_ sortedInfo: [String: [TimeInfo]]) -> [String: [TimeInfo]] {
        var info = sortedInfo
        var prevTime: TimeInfo?
        
        // setup prevTime
        if let sunday = daysOfTheWeek.last,
           let lastTimeInfo = info[sunday]?.last {
            prevTime = lastTimeInfo
        }
        
        // loop through each day's timings to check for overlaps
        for day in daysOfTheWeek {
            guard var time = info[day],
                    !time.isEmpty else {
                prevTime = nil
                continue
            }
            
            // combine with prevTime if needed
            if let prevTime,
               prevTime.endTime == time[0].startTime {
                prevTime.endTime = time[0].endTime
                time.removeFirst()
            }
            
            // loop through timings and combine overlaps
            var i = 0
            while i < time.count - 1 {
                if time[i].endTime >= time[i+1].startTime {
                    time[i].endTime = time[i+1].endTime
                    time.remove(at: i + 1)
                } else {
                    i += 1
                }
            }
            
            info[day] = time
            prevTime = time.last
        }
        
        return info
    }
}
