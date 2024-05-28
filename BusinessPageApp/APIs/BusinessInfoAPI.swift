//
//  BusinessInfoAPI.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/20/24.
//

import Foundation

final class BusinessInfoAPI: BusinessInfoService {
    
    static let locationURL = "https://purs-demo-bucket-test.s3.us-west-2.amazonaws.com/location.json"
    
    func fetchLocationData() async throws -> BusinessInfo {
        let data = try await RequestHandler.fetchData(from: BusinessInfoAPI.locationURL)
        let info: BusinessInfo = try DataParser.parse(from: data)
        return info
    }
}
