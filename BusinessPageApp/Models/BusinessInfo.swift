//
//  BusinessInfo.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/20/24.
//

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
        var hoursByDayTemp = [String: [TimeInfo]]()
        for hourInfo in allHoursInfo {
            hoursByDayTemp[hourInfo.dayOfWeek, default: []]
                .append(TimeInfo(startTime: hourInfo.startLocalTime, endTime: hourInfo.endLocalTime))
        }
        hoursByDay = hoursByDayTemp
    }
}
