//
//  RequestHandler.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/20/24.
//

import Foundation

struct RequestHandler {
    /// Fetches Data from urlString
    /// - Parameters:
    ///   - urlString: url String
    /// - Returns: Data fetched from the url, otherwise throws APIError
    static func fetchData(from urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw APIError.badURL
        }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw APIError.requestFailed
        }
        guard !data.isEmpty else {
            throw APIError.emptyData
        }
        return data
    }
}
