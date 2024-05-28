//
//  DateTimeHelperTests.swift
//  BusinessPageAppTests
//
//  Created by Ralston Goes on 5/28/24.
//

@testable import BusinessPageApp
import XCTest

final class DateTimeHelperTests: XCTestCase {
    
    // MARK: test sortTimes method
    func test_sortTimes() {
        let mockInfo = MockData.weekdayTimingsInfo()
        let sortedTimes = DateTimeHelper.sortTimes(mockInfo)
        
        for day in DateTimeHelper.daysOfTheWeek {
            XCTAssertEqual(sortedTimes[day] ?? [], MockData.sortedWeekdayTimingsInfo()[day] ?? [])
        }
    }
    
    // MARK: test combineOverlappingTimes method
    func test_combineOverlappingTimes() {
        let mockInfo = MockData.sortedWeekdayTimingsInfo()
        let combinedTimes = DateTimeHelper.combineOverlappingTimes(mockInfo)
        let expected = MockData.combinedWeekdayTimingsInfo()
        for day in DateTimeHelper.daysOfTheWeek {
            XCTAssertEqual(combinedTimes[day] ?? [], MockData.combinedWeekdayTimingsInfo()[day] ?? [])
        }
    }
    
    // MARK: test processDateTimes method
    func test_processDateTimes() {
        let mockInfo = MockData.weekdayTimingsInfo()
        let processedTimes = DateTimeHelper.processDateTimes(mockInfo)
        
        for day in DateTimeHelper.daysOfTheWeek {
            XCTAssertEqual(processedTimes[day] ?? [], MockData.combinedWeekdayTimingsInfo()[day] ?? [])
        }
    }
}
