//
//  WeatherAPI.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import Foundation

final class WeatherAPI: WeatherAPIProtocol {
    
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchCurrent(
        lat: Double,
        lon: Double
    ) async throws -> CurrentWeatherDTO {
        try await networkClient.request(
            endpoint: WeatherEndpoint.current(lat: lat, lon: lon)
        )
    }
    
    func fetchForecast(
        lat: Double,
        lon: Double
    ) async throws -> ForecastDTO {
        try await networkClient.request(
            endpoint: WeatherEndpoint.forecast(lat: lat, lon: lon, days: 3)
        )
    }
}
