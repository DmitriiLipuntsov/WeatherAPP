//
//  NetworkClient.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import Foundation

public final class NetworkClient: NetworkClientProtocol {
    private let session: URLSession
    private let config: NetworkConfig
    
    public init(config: NetworkConfig = .default) {
        self.config = config
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = config.timeout
        sessionConfig.timeoutIntervalForResource = config.timeout
        
        self.session = URLSession(configuration: sessionConfig)
    }
}

extension NetworkClient {
    public func request<T: Decodable>(
        endpoint: Endpoint
    ) async throws -> T {
        let request = try buildRequest(from: endpoint)
        return try await performRequest(
            request: request,
            retryCount: config.retryCount
        )
    }
}

private extension NetworkClient {
    func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw APIError.invalidURL
        }
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }
        
        return request
    }
}

private extension NetworkClient {
    func performRequest<T: Decodable>(
        request: URLRequest,
        retryCount: Int
    ) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            try validate(response: response, data: data)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            let apiError = mapError(error)
            if retryCount > 0, shouldRetry(for: apiError) {
                return try await performRequest(
                    request: request,
                    retryCount: retryCount - 1
                )
            }
            throw apiError
        }
    }
}

private extension NetworkClient {
    func validate(response: URLResponse, data: Data) throws {
        guard let http = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        switch http.statusCode {
        case 200...299:
            return
        case 401:
            throw APIError.unauthorized
        case 403:
            throw APIError.forbidden
        case 404:
            throw APIError.notFound
        case 500...599:
            throw APIError.serverError(statusCode: http.statusCode, message: nil)
        default:
            throw APIError.serverError(statusCode: http.statusCode, message: nil)
        }
    }
}

private extension NetworkClient {
    func mapError(_ error: Error) -> APIError {
        if let apiError = error as? APIError { return apiError }

        if let urlError = error as? URLError {
            switch urlError.code {
            case .timedOut:
                return .timeout
            case .notConnectedToInternet:
                return .noInternet
            case .cancelled:
                return .cancelled
            case .cannotFindHost:
                return .network(hint: "\nIf you use a VPN, try turning it off.")
            default:
                return .network()
            }
        }

        if error is DecodingError { return .decoding }
        return .unknown
    }
}

private extension NetworkClient {
    func shouldRetry(for error: APIError) -> Bool {
        switch error {
        case .timeout,
             .noInternet,
             .network:
            return true
        default:
            return false
        }
    }
}
