//
//  BusinessInfoViewModel.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/20/24.
//

import Foundation

final class BusinessInfoViewModel: ObservableObject {
    
    @Published var state: ViewState
    @Published var weeklyTimes = [String: [TimeInfo]]()
    @Published var locationText: String
    @Published var isOpenText: String
    @Published var isOpenNowState: BusinessOpenState
    var apiService: BusinessInfoService
    
    var daysOfTheWeek: [String] {
        DateTimeHelper.daysOfTheWeek
    }
    
    init(state: ViewState = .loading, apiService: BusinessInfoService = BusinessInfoAPI()) {
        self.state = state
        self.locationText = ""
        self.isOpenText = ""
        self.isOpenNowState = .closed
        self.apiService = apiService
    }
    
    func loadInfo() async {
        updateState(.loading)
        do {
            let info = try await apiService.fetchLocationData()
            await MainActor.run {
                state = .loaded
                locationText = info.locationName
                weeklyTimes = DateTimeHelper.processDateTimes(info.hoursByDay)
                isOpenNowState = setBusinessOpenState()
                isOpenText = setBusinessOpenText()
            }
        } catch let apiError as APIError {
            print("APIError: \(apiError.localizedDescription)")
            updateState(.error)
        } catch {
            print("Error: \(error.localizedDescription)")
            updateState(.error)
        }
    }
    
    func updateState(_ vs: ViewState) {
        Task { @MainActor in
            state = vs
        }
    }
    
    func setTimeRangeText(from start: Date, to end: Date) -> String {
        guard let diff = Calendar.current.dateComponents([.hour], from: start, to: end).hour, diff < 24 else { return "Open 24 hours" }
        let startTime = start.simplifyTimeFromHMS(isUppercased: true)
        let endTime = end.simplifyTimeFromHMS(isUppercased: true)
        return startTime + "-" + endTime
    }
    
    func setBusinessOpenState() -> BusinessOpenState {
        let currentDate = Date()
        let weekday = currentDate.weekday()
        guard let timeInfo = weeklyTimes[weekday] else {
            return .closed
        }
        
        for t in timeInfo where t.startTime <= currentDate && currentDate < t.endTime {
            guard let diff = Calendar.current.dateComponents([.minute], from: currentDate, to: t.endTime).minute,
                  diff >= 60  else { return .closing }
            return .open
        }
        return .closed
    }
    
    /*
     Text format:  
     ”Open until {time}”
     “Open until {time}, reopens at {next time block}”
     “Opens again at {time}” If the next open period begins within 24h.
     “Opens {day} {time}” if the next open period begins greater than 24 hours in the future.

     */
    func setBusinessOpenText() -> String {
        var res = ""
        let currentDate = Date()
        let weekday = currentDate.weekday()
        if let timeInfo = weeklyTimes[weekday],
           let index = timeInfo.firstIndex(where: { $0.startTime <= currentDate && currentDate < $0.endTime } ) {
            res = "Open until \(timeInfo[index].endTime.simplifyTimeFromHMS())"
            guard index+1 < timeInfo.count else {
                return res
            }
            res += ", reopens at \(timeInfo[index+1].endTime.simplifyTimeFromHMS())"
            return res
        }
        
        let weekdaySymbols = Calendar.current.weekdaySymbols
        guard let startIndex = weekdaySymbols.firstIndex(of: weekday.capitalized) else {
            return res
        }
        
        res = "Opens \(weekday) \(weeklyTimes[weekday]?.first?.startTime.simplifyTimeFromHMS() ?? "")"
        var index = (startIndex + 1) % 7
        while index != startIndex {
            let nextWeekDay = weekdaySymbols[index]
            guard let nextTimeInfo = weeklyTimes[nextWeekDay],
                  let nextTime = nextTimeInfo.first?.startTime,
                  let hours = Calendar.current.dateComponents([.hour], from: currentDate, to: nextTime)
                .hour else {
                index = ((index + 1) % 7)
                continue
            }
            
            if hours < 24 {
                res = "Opens again at \(nextTime.simplifyTimeFromHMS())"
            } else {
                res = "Opens \(nextWeekDay) \(nextTime.simplifyTimeFromHMS())"
            }
            return res
        }
        return res
    }
    
}
