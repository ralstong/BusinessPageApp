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
    
    enum CodingKeys: String, CodingKey {
        case locationName
        case hours
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        locationName = try container.decodeIfPresent(String.self, forKey: .locationName) ?? ""
        
        guard let allHoursInfo = try? container.decode([HoursInfo].self, forKey: .hours) else {
            hoursByDay = [:]
            return
        }
        hoursByDay = BusinessInfo.configureHoursByDay(from: allHoursInfo)
    }
    
    private static func configureHoursByDay(from hoursInfo: [HoursInfo], currentDate: Date = Date()) -> [String: [TimeInfo]] {
        var dayTimeInfo = [String: [TimeInfo]]()
        for info in hoursInfo {
            guard let day = info.dayOfWeek.convertToFullWeekday(),
                  let startTime = currentDate.dateFrom(weekday: day, time: info.startLocalTime),
                  let endTime = currentDate.dateFrom(weekday: day, time: info.endLocalTime) else {
                print("Error creating TimeInfo object")
                continue
            }
            dayTimeInfo[day, default: []].append(TimeInfo(startTime: startTime, endTime: endTime))
        }
        return dayTimeInfo
    }
}
