//
//  DateExtensionTests.swift
//  BusinessPageAppTests
//
//  Created by Ralston Goes on 5/28/24.
//

@testable import BusinessPageApp
import XCTest

final class DateExtensionTests: XCTestCase {
    
    var calendar: Calendar!
    var dateTimeformatter: DateFormatter!
    var dateOnlyFormatter: DateFormatter!
    
    override func setUp() {
        super.setUp()
        calendar = Calendar.current
        dateTimeformatter = DateFormatter()
        dateTimeformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateOnlyFormatter = DateFormatter()
        dateOnlyFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    override func tearDown() {
        calendar = nil
        dateTimeformatter = nil
        dateOnlyFormatter = nil
        super.tearDown()
    }
    
    func createTestDateTime(_ dateString: String) -> Date {
        dateTimeformatter.date(from: dateString)!
    }
    
    func createTestDateOnly(_ dateString: String) -> Date {
        dateOnlyFormatter.date(from: dateString)!
    }
    
    // MARK: test simplifyTimeFromHMS method
    func test_simplifyTimeFromHMS_uppercaseAM() {
        let testDate = createTestDateTime("2024-05-28 08:00:00")
        XCTAssertEqual(testDate.simplifyTimeFromHMS(isUppercased: true), "8AM")
    }
    
    func test_simplifyTimeFromHMS_lowercaseAM() {
        let testDate = createTestDateTime("2024-05-28 08:00:00")
        XCTAssertEqual(testDate.simplifyTimeFromHMS(isUppercased: false), "8am")
    }
    
    func test_simplifyTimeFromHMS_withMinutesPM() {
        let testDate = createTestDateTime("2024-05-28 15:30:00")
        XCTAssertEqual(testDate.simplifyTimeFromHMS(isUppercased: false), "3:30pm")
    }
    
    func test_simplifyTimeFromHMS_noonPM() {
        let testDate = createTestDateTime("2024-05-28 12:00:00")
        XCTAssertEqual(testDate.simplifyTimeFromHMS(isUppercased: true), "12PM")
    }
    
    func test_simplifyTimeFromHMS_midnight() {
        let testDate = createTestDateTime("2024-05-28 00:00:00")
        XCTAssertEqual(testDate.simplifyTimeFromHMS(isUppercased: true), "12AM")
    }
    
    // MARK: test weekday method
    func test_weekday_monday() {
        let testDate = createTestDateOnly("2024-05-27")
        XCTAssertEqual(testDate.weekday(), "Monday")
    }
    
    func test_weekday_tuesday() {
        let testDate = createTestDateOnly("2024-05-28")
        XCTAssertEqual(testDate.weekday(), "Tuesday")
    }
    
    func test_weekday_wednesday() {
        let testDate = createTestDateOnly("2024-05-29")
        XCTAssertEqual(testDate.weekday(), "Wednesday")
    }
    
    func test_weekday_thursday() {
        let testDate = createTestDateOnly("2024-05-30")
        XCTAssertEqual(testDate.weekday(), "Thursday")
    }
    
    func test_weekday_friday() {
        let testDate = createTestDateOnly("2024-05-31")
        XCTAssertEqual(testDate.weekday(), "Friday")
    }
    
    func test_weekday_saturday() {
        let testDate = createTestDateOnly("2024-06-01")
        XCTAssertEqual(testDate.weekday(), "Saturday")
    }
    
    func test_weekday_sunday() {
        let testDate = createTestDateOnly("2024-06-02")
        XCTAssertEqual(testDate.weekday(), "Sunday")
    }
    
    // MARK: test dateFrom(weekday:, time:) method
    func test_dateFromWeekdayAndTime_mondayNoon() {
        let testWeekday = "Monday"
        let testDate = Date().dateFrom(weekday: testWeekday, time: "12:00:00")
        let testComponents = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: testDate ?? Date())
        
        let weekdaySymbols = calendar.weekdaySymbols
        guard let weekdayIndex = weekdaySymbols.firstIndex(of: testWeekday) else {
            XCTFail("Failed to retrieve day of the week index")
            return
        }
        let adjustedIndex = (weekdayIndex % 7) + 1
        let mockComponents = DateComponents(hour: 12, minute: 0, second: 0, weekday: adjustedIndex)
        XCTAssertEqual(testComponents.hour, mockComponents.hour)
        XCTAssertEqual(testComponents.minute, mockComponents.minute)
        XCTAssertEqual(testComponents.second, mockComponents.second)
        XCTAssertEqual(testComponents.weekday, mockComponents.weekday)
    }
    
    func test_dateFromWeekdayAndTime_saturday10pm() {
        let testWeekday = "Saturday"
        let testDate = Date().dateFrom(weekday: testWeekday, time: "22:00:00")
        let testComponents = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: testDate ?? Date())
        
        let weekdaySymbols = calendar.weekdaySymbols
        guard let weekdayIndex = weekdaySymbols.firstIndex(of: testWeekday) else {
            XCTFail("Failed to retrieve day of the week index")
            return
        }
        let adjustedIndex = (weekdayIndex % 7) + 1
        let mockComponents = DateComponents(hour: 22, minute: 0, second: 0, weekday: adjustedIndex)
        XCTAssertEqual(testComponents.hour, mockComponents.hour)
        XCTAssertEqual(testComponents.minute, mockComponents.minute)
        XCTAssertEqual(testComponents.second, mockComponents.second)
        XCTAssertEqual(testComponents.weekday, mockComponents.weekday)
    }
    
    func test_dateFromWeekdayAndTime_sunday12am() {
        let testWeekday = "Sunday"
        let testDate = Date().dateFrom(weekday: testWeekday, time: "00:00:00")
        let testComponents = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: testDate ?? Date())
        
        let weekdaySymbols = calendar.weekdaySymbols
        guard let weekdayIndex = weekdaySymbols.firstIndex(of: testWeekday) else {
            XCTFail("Failed to retrieve day of the week index")
            return
        }
        let adjustedIndex = (weekdayIndex % 7) + 1
        let mockComponents = DateComponents(hour: 0, minute: 0, second: 0, weekday: adjustedIndex)
        XCTAssertEqual(testComponents.hour, mockComponents.hour)
        XCTAssertEqual(testComponents.minute, mockComponents.minute)
        XCTAssertEqual(testComponents.second, mockComponents.second)
        XCTAssertEqual(testComponents.weekday, mockComponents.weekday)
    }
    
    
    //MARK: test nextDate(to time:) method
    func test_nextDateToTime_withinSameDay() {
        let testDate = createTestDateTime("2024-05-28 08:00:00")
        let resultDate = dateTimeformatter.date(from: "2024-05-28 12:00:00")!
        XCTAssertEqual(testDate.nextDate(to: "12:00:00"), resultDate)
    }
    
    func test_nextDateToTime_dateInNextDay() {
        let testDate = createTestDateTime("2024-05-28 22:00:00")
        let resultDate = dateTimeformatter.date(from: "2024-05-29 02:00:00")!
        XCTAssertEqual(testDate.nextDate(to: "02:00:00"), resultDate)
    }
}
