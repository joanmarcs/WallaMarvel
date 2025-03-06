//
//  ApiError.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case serverError
    case networkError(String)
    case decodingError(String)

    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The request URL is invalid."
        case .serverError:
            return "Server responded with an error."
        case .networkError(let message):
            return "Network error: \(message)"
        case .decodingError(let message):
            return "Failed to decode response: \(message)"
        }
    }
}
