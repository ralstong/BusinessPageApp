//
//  DataParsingHandler.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/20/24.
//

import Foundation

struct DataParser {
    static func parse<T: Decodable>(from data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = try? decoder.decode(T.self, from: data) else {
            throw APIError.decodingFailed
        }
        return data
    }
}
