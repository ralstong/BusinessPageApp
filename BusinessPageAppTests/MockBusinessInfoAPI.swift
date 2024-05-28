//
//  MockBusinessInfoAPI.swift
//  BusinessPageAppTests
//
//  Created by Ralston Goes on 5/27/24.
//

@testable import BusinessPageApp
import Foundation

class MockBusinessInfoAPI: BusinessInfoService {
    var isFailure = false
    
    func fetchLocationData() async throws -> BusinessPageApp.BusinessInfo {
        guard !isFailure else {
            throw APIError.unknownError
        }
        return BusinessInfo(locationName: "Some Location",
                            hoursByDay: MockData.weekdayTimingsInfo())
    }
}
