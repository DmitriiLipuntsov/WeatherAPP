//
//  NetworkClientProtocol.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation

protocol NetworkClientProtocol {
    func request<T: Decodable>(
        endpoint: Endpoint
    ) async throws -> T
}
