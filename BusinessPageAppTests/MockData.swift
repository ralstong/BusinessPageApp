//
//  MockData.swift
//  BusinessPageAppTests
//
//  Created by Ralston Goes on 5/27/24.
//

@testable import BusinessPageApp
import Foundation

enum MockData {
    static let hoursInfo: [HoursInfo] = [
        .init(dayOfWeek: "WED", startLocalTime: "00:00:00", endLocalTime: "02:00:00"),
        .init(dayOfWeek: "WED", startLocalTime: "07:30:00", endLocalTime: "13:00:00"),
        .init(dayOfWeek: "TUE", startLocalTime: "15:00:00", endLocalTime: "18:00:00"),
        .init(dayOfWeek: "TUE", startLocalTime: "06:00:00", endLocalTime: "15:00:00"),
        .init(dayOfWeek: "MON", startLocalTime: "13:00:00", endLocalTime: "14:00:00"),
        .init(dayOfWeek: "TUE", startLocalTime: "20:00:00", endLocalTime: "24:00:00"),
        .init(dayOfWeek: "FRI", startLocalTime: "00:00:00", endLocalTime: "24:00:00"),
        .init(dayOfWeek: "SAT", startLocalTime: "12:00:00", endLocalTime: "18:00:00"),
        .init(dayOfWeek: "SUN", startLocalTime: "13:00:00", endLocalTime: "24:00:00")
    ]
    
    static let weekdayTimingsInfo: [String: [TimeInfo]] = [
        "Wednesday": [.init(startTime: "00:00:00".dateFromHMSTime() ?? Date(), endTime: "04:00:00".dateFromHMSTime() ?? Date())],
        "Thursday": [.init(startTime: "14:00:00".dateFromHMSTime() ?? Date(), endTime: "23:00:00".dateFromHMSTime() ?? Date())]
    ]
}
