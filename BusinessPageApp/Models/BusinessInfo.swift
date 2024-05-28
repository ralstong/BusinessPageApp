//
//  BusinessInfo.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/20/24.
//

import Foundation

struct BusinessInfo {
    let locationName: String
    let hoursByDay: [String: [TimeInfo]]
}

extension BusinessInfo: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case locationName
        case hours
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        locationName = try container.decodeIfPresent(String.self, forKey: .locationName) ?? ""
        let allHoursInfo: [HoursInfo] = try container.decodeIfPresent([HoursInfo].self, forKey: .hours) ?? []
        hoursByDay = BusinessInfo.configureHoursByDay(from: allHoursInfo)
    }
    
    /// Returns an organized dictionary from the default hours info array containing key as the day of the week and value as an array of TimeInfo objects containing the start and end times
    /// - Parameters:
    ///   - hoursInfo: HoursInfo Array containing the weekday and timing information
    ///   - currentDate: The current date. A default Date() instance is provided by default
    /// - Returns: The structured dictionary containing key as day of the week string and value as TimeInfo array
    private static func configureHoursByDay(from hoursInfo: [HoursInfo], currentDate: Date = Date()) -> [String: [TimeInfo]] {
        var dayTimeInfo = [String: [TimeInfo]]()
        for info in hoursInfo {
            guard let day = info.dayOfWeek.convertToFullWeekday(),
                  let startTime = currentDate.dateFrom(weekday: day, time: info.startLocalTime),
                  let endTime = startTime.nextDate(to: info.endLocalTime) else {
                print("Error creating TimeInfo object")
                continue
            }
            dayTimeInfo[day, default: []].append(TimeInfo(startTime: startTime, endTime: endTime))
        }
        return dayTimeInfo
    }
}
