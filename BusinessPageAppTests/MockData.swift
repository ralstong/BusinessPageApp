//
//  MockData.swift
//  BusinessPageAppTests
//
//  Created by Ralston Goes on 5/27/24.
//

@testable import BusinessPageApp
import Foundation

enum MockData {
    
    static func weekdayTimingsInfo(currentDate: Date = Date()) -> [String: [TimeInfo]] {
        [
            "Wednesday": [
                .init(startTime: currentDate.dateFrom(weekday: "Wednesday", time: "00:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Wednesday", time: "02:00:00") ?? Date()),
                .init(startTime: currentDate.dateFrom(weekday: "Wednesday", time: "07:30:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Wednesday", time: "13:00:00") ?? Date())
            ],
            "Sunday": [
                .init(startTime: currentDate.dateFrom(weekday: "Sunday", time: "13:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Sunday", time: "24:00:00") ?? Date())
            ],
            "Tuesday": [
                .init(startTime: currentDate.dateFrom(weekday: "Tuesday", time: "15:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Tuesday", time: "18:00:00") ?? Date()),
                .init(startTime: currentDate.dateFrom(weekday: "Tuesday", time: "06:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Tuesday", time: "15:00:00") ?? Date()),
                .init(startTime: currentDate.dateFrom(weekday: "Tuesday", time: "20:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Wednesday", time: "00:00:00") ?? Date())
            ],
            "Saturday": [
                .init(startTime: currentDate.dateFrom(weekday: "Saturday", time: "12:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Saturday", time: "18:00:00") ?? Date())
            ],
            "Monday": [
                .init(startTime: currentDate.dateFrom(weekday: "Monday", time: "13:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Monday", time: "14:00:00") ?? Date())
            ],
            "Friday": [
                .init(startTime: currentDate.dateFrom(weekday: "Friday", time: "00:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Friday", time: "24:00:00") ?? Date())
            ]
        ]
    }
    
    static func sortedWeekdayTimingsInfo(currentDate: Date = Date()) -> [String: [TimeInfo]] {
        [
            "Wednesday": [
                .init(startTime: currentDate.dateFrom(weekday: "Wednesday", time: "00:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Wednesday", time: "02:00:00") ?? Date()),
                .init(startTime: currentDate.dateFrom(weekday: "Wednesday", time: "07:30:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Wednesday", time: "13:00:00") ?? Date())
            ],
            "Sunday": [
                .init(startTime: currentDate.dateFrom(weekday: "Sunday", time: "13:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Sunday", time: "24:00:00") ?? Date())
            ],
            "Tuesday": [
                .init(startTime: currentDate.dateFrom(weekday: "Tuesday", time: "06:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Tuesday", time: "15:00:00") ?? Date()),
                .init(startTime: currentDate.dateFrom(weekday: "Tuesday", time: "15:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Tuesday", time: "18:00:00") ?? Date()),
                .init(startTime: currentDate.dateFrom(weekday: "Tuesday", time: "20:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Wednesday", time: "00:00:00") ?? Date())
            ],
            "Saturday": [
                .init(startTime: currentDate.dateFrom(weekday: "Saturday", time: "12:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Saturday", time: "18:00:00") ?? Date())
            ],
            "Monday": [
                .init(startTime: currentDate.dateFrom(weekday: "Monday", time: "13:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Monday", time: "14:00:00") ?? Date())
            ],
            "Friday": [
                .init(startTime: currentDate.dateFrom(weekday: "Friday", time: "00:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Friday", time: "24:00:00") ?? Date())
            ]
        ]
    }
    
    static func combinedWeekdayTimingsInfo(currentDate: Date = Date()) -> [String: [TimeInfo]] {
        [
            "Wednesday": [
                .init(startTime: currentDate.dateFrom(weekday: "Wednesday", time: "07:30:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Wednesday", time: "13:00:00") ?? Date())
            ],
            "Sunday": [
                .init(startTime: currentDate.dateFrom(weekday: "Sunday", time: "13:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Sunday", time: "24:00:00") ?? Date())
            ],
            "Tuesday": [
                .init(startTime: currentDate.dateFrom(weekday: "Tuesday", time: "06:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Tuesday", time: "18:00:00") ?? Date()),
                .init(startTime: currentDate.dateFrom(weekday: "Tuesday", time: "20:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Wednesday", time: "02:00:00") ?? Date())
            ],
            "Saturday": [
                .init(startTime: currentDate.dateFrom(weekday: "Saturday", time: "12:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Saturday", time: "18:00:00") ?? Date())
            ],
            "Monday": [
                .init(startTime: currentDate.dateFrom(weekday: "Monday", time: "13:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Monday", time: "14:00:00") ?? Date())
            ],
            "Friday": [
                .init(startTime: currentDate.dateFrom(weekday: "Friday", time: "00:00:00") ?? Date(),
                      endTime: currentDate.dateFrom(weekday: "Friday", time: "24:00:00") ?? Date())
            ]
        ]
    }
}
