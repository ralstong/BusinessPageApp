//
//  TimeInfo.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/20/24.
//

import Foundation

//struct TimeInfo {
//    let startTime: Date
//    let endTime: Date
//}

final class TimeInfo {
    var startTime: Date
    var endTime: Date
    
    init(startTime: Date, endTime: Date) {
        self.startTime = startTime
        self.endTime = endTime
    }
}

extension TimeInfo: Equatable {
    static func == (lhs: TimeInfo, rhs: TimeInfo) -> Bool {
        lhs.startTime == rhs.startTime && lhs.endTime == rhs.endTime
    }
}
