//
//  APIError.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import Foundation

public enum APIError: LocalizedError, Equatable {
    case invalidURL
    case network(hint: String? = nil) // добавляем optional hint
    case timeout
    case noInternet
    case cancelled
    case decoding
    case serverError(statusCode: Int, message: String?)
    case unauthorized
    case forbidden
    case notFound
    case unknown

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .network(let hint):
            if let hint = hint {
                return "Network error occurred. \(hint)"
            }
            return "Network error occurred."
        case .timeout:
            return "Request timed out."
        case .noInternet:
            return "No internet connection."
        case .cancelled:
            return "Request was cancelled."
        case .decoding:
            return "Failed to decode server response."
        case .serverError(_, let message):
            return message ?? "Server error."
        case .unauthorized:
            return "Unauthorized request."
        case .forbidden:
            return "Access forbidden."
        case .notFound:
            return "Resource not found."
        case .unknown:
            return "Unknown error occurred."
        }
    }
}
