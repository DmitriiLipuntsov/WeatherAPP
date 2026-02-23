//
//  GetWeatherUseCase.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import Foundation

final class GetWeatherUseCase {
    
    // MARK: - Dependencies
    private let repository: WeatherRepositoryImpl
    
    // MARK: - Initializer
    init(repository: WeatherRepositoryImpl) {
        self.repository = repository
    }
}

// MARK: - Public API
extension GetWeatherUseCase {
    func execute(
        lat: Double,
        lon: Double
    ) async throws -> WeatherAggregate {
        async let current = repository.fetchCurrentWeather(lat: lat, lon: lon)
        async let forecast = repository.fetchForecast(lat: lat, lon: lon)
        
        return try await WeatherAggregate(
            current: current,
            forecast: forecast
        )
    }
}
