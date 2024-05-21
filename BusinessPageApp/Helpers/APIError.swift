//
//  APIError.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/20/24.
//

enum APIError: Error {
    case badURL
    case requestFailed
    case decodingFailed
    case emptyData
    case unknownError
}
