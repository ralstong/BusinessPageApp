//
//  BusinessInfoViewModelTests.swift
//  BusinessPageAppTests
//
//  Created by Ralston Goes on 5/27/24.
//

@testable import BusinessPageApp
import XCTest

final class BusinessInfoViewModelTests: XCTestCase {
    
    var viewModel: BusinessInfoViewModel!
    var mockService = MockBusinessInfoAPI()
    
    override func setUp() {
        super.setUp()
        viewModel = BusinessInfoViewModel(apiService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_initialViewModelSetup() {
        XCTAssertEqual(viewModel.state, .loading)
        XCTAssertEqual(viewModel.openIndicatorState, .closed)
        XCTAssertEqual(viewModel.currentOpenText, "")
        XCTAssertEqual(viewModel.locationText, "")
    }
    
    // MARK: test loadInfo method
    func test_loadInfo_failure() async {
        let expectation = expectation(description: "Loading info fails")
        mockService.isFailure = true
        await viewModel.loadInfo()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            XCTAssertEqual(self?.viewModel.state, .error)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 3)
    }
    
    func test_loadInfo_success() async {
        let expectation = expectation(description: "Loading info succeeds")
        await viewModel.loadInfo()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            XCTAssertEqual(self?.viewModel.state, .loaded)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 3)
    }
    
    // MARK: test formatTimeRangeText method
    func test_formatTimeRangeText_open24Hours() {
        let calendar = Calendar.current
        guard let start = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date()),
              let end = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: start.addingTimeInterval(24 * 60 * 60)) else {
            XCTFail("Failed to set date")
            return
        }
        
        let result = viewModel.formatTimeRangeText(from: start, to: end)
        XCTAssertEqual(result, "Open 24 hours")
    }
    
    func test_formatTimeRangeText_within24Hours() {
        let calendar = Calendar.current
        guard let start = calendar.date(bySettingHour: 9, minute: 0, second: 0, of: Date()),
              let end = calendar.date(bySettingHour: 17, minute: 0, second: 0, of: start) else {
            XCTFail("Failed to set date")
            return
        }
        
        let result = viewModel.formatTimeRangeText(from: start, to: end)
        XCTAssertEqual(result, "9AM-5PM")
    }
    
    func test_formatTimeRangeText_acrossMidnight() {
        let calendar = Calendar.current
        guard let start = calendar.date(bySettingHour: 22, minute: 0, second: 0, of: Date()),
              let end = calendar.date(bySettingHour: 4, minute: 0, second: 0, of: start.addingTimeInterval(6 * 60 * 60)) else {
            XCTFail("Failed to set date")
            return
        }
        
        let result = viewModel.formatTimeRangeText(from: start, to: end)
        XCTAssertEqual(result, "10PM-4AM")
    }
    
    func test_formatTimeRangeText_includesMinutes() {
        let calendar = Calendar.current
        guard let start = calendar.date(bySettingHour: 12, minute: 30, second: 0, of: Date()),
              let end = calendar.date(bySettingHour: 15, minute: 15, second: 0, of: start) else {
            XCTFail("Failed to set date")
            return
        }
        
        let result = viewModel.formatTimeRangeText(from: start, to: end)
        XCTAssertEqual(result, "12:30PM-3:15PM")
    }
    
    func test_formatTimeRangeText_withTrailingCharacter() {
        let calendar = Calendar.current
        guard let start = calendar.date(bySettingHour: 10, minute: 0, second: 0, of: Date()),
              let end = calendar.date(bySettingHour: 11, minute: 0, second: 0, of: start) else {
            XCTFail("Failed to set date")
            return
        }
        
        let result = viewModel.formatTimeRangeText(from: start, to: end, hasTrailingCharacter: true)
        XCTAssertEqual(result, "10AM-11AM,")
    }
    
    // MARK: test setBusinessOpenState method
    func test_setBusinessOpenState_closed() {
        let currentDate = Date()
        guard let startTime = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate),
              let endTime = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate) else {
            XCTFail("Failed to set date")
            return
        }
        let timeInfo = [TimeInfo(startTime: startTime, endTime: endTime)]
        let indicator = viewModel.setOpenIndicatorState(currentDate: currentDate, timeInfo: timeInfo)
        XCTAssertEqual(indicator, .closed)
    }
    
    func test_setBusinessOpenState_closing() {
        let currentDate = Date()
        guard let startTime = Calendar.current.date(byAdding: .hour, value: -1, to: currentDate),
              let endTime = Calendar.current.date(byAdding: .minute, value: 30, to: currentDate) else {
            XCTFail("Failed to set date")
            return
        }
        let timeInfo = [TimeInfo(startTime: startTime, endTime: endTime)]
        let indicator = viewModel.setOpenIndicatorState(currentDate: currentDate, timeInfo: timeInfo)
        XCTAssertEqual(indicator, .closing)
    }
    
    func test_setBusinessOpenState_open() {
        let currentDate = Date()
        guard let startTime = Calendar.current.date(byAdding: .hour, value: -1, to: currentDate),
              let endTime = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate) else {
            XCTFail("Failed to set date")
            return
        }
        let timeInfo = [TimeInfo(startTime: startTime, endTime: endTime)]
        let indicator = viewModel.setOpenIndicatorState(currentDate: currentDate, timeInfo: timeInfo)
        XCTAssertEqual(indicator, .open)
    }
    
    func test_setBusinessOpenState_exactly1HourBeforeClosing() {
        let currentDate = Date()
        guard let startTime = Calendar.current.date(byAdding: .hour, value: -2, to: currentDate),
              let endTime = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate) else {
            XCTFail("Failed to set date")
            return
        }
        let timeInfo = [TimeInfo(startTime: startTime, endTime: endTime)]
        let indicator = viewModel.setOpenIndicatorState(currentDate: currentDate, timeInfo: timeInfo)
        XCTAssertEqual(indicator, .open)
    }
    
    func test_setBusinessOpenState_multipleTimings() {
        let currentDate = Date()
        guard let startTime1 = Calendar.current.date(byAdding: .hour, value: -3, to: currentDate),
              let endTime1 = Calendar.current.date(byAdding: .hour, value: -2, to: currentDate),
              let startTime2 = Calendar.current.date(byAdding: .hour, value: -1, to: currentDate),
              let endTime2 = Calendar.current.date(byAdding: .hour, value: 3, to: currentDate),
              let startTime3 = Calendar.current.date(byAdding: .hour, value: 6, to: currentDate),
              let endTime3 = Calendar.current.date(byAdding: .hour, value: 8, to: currentDate) else {
            XCTFail("Failed to set date")
            return
        }
        let timeInfo = [TimeInfo(startTime: startTime1, endTime: endTime1),
                        TimeInfo(startTime: startTime2, endTime: endTime2),
                        TimeInfo(startTime: startTime3, endTime: endTime3)]
        let indicator = viewModel.setOpenIndicatorState(currentDate: currentDate, timeInfo: timeInfo)
        XCTAssertEqual(indicator, .open)
    }
    
    // MARK: test setCurrentOpenText method
    func test_setCurrentOpenText_openUntilTime() {
        let currentDate = Date()
        guard let testDate = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: currentDate),
              let startTime = Calendar.current.date(byAdding: .hour, value: -1, to: testDate),
              let endTime = Calendar.current.date(byAdding: .hour, value: 2, to: testDate) else {
            XCTFail("Failed to set date")
            return
        }
        let weekday = testDate.weekday()
        let timeInfo = [TimeInfo(startTime: startTime, endTime: endTime)]
        let text = viewModel.setCurrentOpenText(currentDate: testDate, weeklyTimeInfo: [weekday: timeInfo])
        XCTAssertTrue(text.hasPrefix("Open until"))
    }
    
    func test_setCurrentOpenText_reopensAt() {
        let currentDate = Date()
        guard let testDate = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: currentDate),
              let startTime1 = Calendar.current.date(byAdding: .hour, value: -1, to: testDate),
              let endTime1 = Calendar.current.date(byAdding: .hour, value: 2, to: testDate),
              let startTime2 = Calendar.current.date(byAdding: .hour, value: 4, to: testDate),
              let endTime2 = Calendar.current.date(byAdding: .hour, value: 6, to: testDate) else {
            XCTFail("Failed to set date")
            return
        }
        let weekday = testDate.weekday()
        let timeInfo = [TimeInfo(startTime: startTime1, endTime: endTime1),
                        TimeInfo(startTime: startTime2, endTime: endTime2)]
        let text = viewModel.setCurrentOpenText(currentDate: testDate, weeklyTimeInfo: [weekday: timeInfo])
        XCTAssertTrue(text.contains("reopens at"))
    }
    
    func test_setCurrentOpenText_opensWithin24h() {
        let currentDate = Date()
        guard let testDate = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: currentDate),
              let startTime1 = Calendar.current.date(byAdding: .hour, value: 12, to: testDate),
              let endTime1 = Calendar.current.date(byAdding: .hour, value: 2, to: startTime1) else {
            XCTFail("Failed to set date")
            return
        }
        let weekdaySymbols = Calendar.current.weekdaySymbols
        guard let startIndex = weekdaySymbols.firstIndex(of: testDate.weekday().capitalized) else {
            XCTFail("Failed to get weekday start index")
            return
        }
        let index = (startIndex + 1) % 7
        let nextWeekDay = weekdaySymbols[index]
        let timeInfo = [TimeInfo(startTime: startTime1, endTime: endTime1)]
        let text = viewModel.setCurrentOpenText(currentDate: testDate, weeklyTimeInfo: [nextWeekDay: timeInfo])
        XCTAssertTrue(text.hasPrefix("Opens again at"))
    }
    
    func test_setCurrentOpenText_opensSometimeAfter24h() {
        let currentDate = Date()
        guard let testDate = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: currentDate),
              let startTime1 = Calendar.current.date(byAdding: .hour, value: 24 * 2, to: testDate),
              let endTime1 = Calendar.current.date(byAdding: .hour, value: 24 * 2 + 4, to: startTime1) else {
            XCTFail("Failed to set date")
            return
        }
        let nextOpenDay = startTime1.weekday()
        let timeInfo = [TimeInfo(startTime: startTime1, endTime: endTime1)]
        let text = viewModel.setCurrentOpenText(currentDate: testDate, weeklyTimeInfo: [nextOpenDay: timeInfo])
        XCTAssertTrue(text.hasPrefix("Opens"))
        XCTAssertFalse(text.hasPrefix("Opens again at"))
    }
}
