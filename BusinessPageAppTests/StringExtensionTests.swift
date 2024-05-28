//
//  StringExtensionTests.swift
//  BusinessPageAppTests
//
//  Created by Ralston Goes on 5/28/24.
//

@testable import BusinessPageApp
import XCTest

final class StringExtensionTests: XCTestCase {
    
    // MARK: test dateFromHMSTime method
    func test_dateFromHMSTime_success() {
        let testDate = "04:00:00".dateFromHMSTime()
        XCTAssertNotNil(testDate)
        let testComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: testDate ?? Date())
        let mockComponents = DateComponents(hour: 4, minute: 0, second: 0)
        XCTAssertEqual(testComponents.hour, mockComponents.hour)
        XCTAssertEqual(testComponents.minute, mockComponents.minute)
        XCTAssertEqual(testComponents.second, mockComponents.second)
    }
    
    func test_dateFromHMSTime_failure() {
        let testDate = "24:00:00".dateFromHMSTime()
        XCTAssertNil(testDate)
    }
    
    // MARK: test convertToFullWeekday method
    func test_convertToFullWeekday_lowercase() {
        let testDay = "thu"
        XCTAssertEqual(testDay.convertToFullWeekday(), "Thursday")
    }
    
    func test_convertToFullWeekday_uppercase() {
        let testDay = "THU"
        XCTAssertEqual(testDay.convertToFullWeekday(), "Thursday")
    }
    
    func test_convertToFullWeekday_failure() {
        let testDay = "THUR"
        XCTAssertNil(testDay.convertToFullWeekday())
    }
}
