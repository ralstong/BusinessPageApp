//
//  Protocols.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/27/24.
//

protocol BusinessInfoService {
    func fetchLocationData() async throws -> BusinessInfo
}
