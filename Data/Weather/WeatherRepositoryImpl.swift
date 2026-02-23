//
//  WeatherRepositoryImpl.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import Foundation

final class WeatherRepositoryImpl: WeatherRepositoryProtocol {
    
    // MARK: - Dependencies
    private let api: WeatherAPIProtocol
    
    // MARK: - Initializer
    init(api: WeatherAPIProtocol) {
        self.api = api
    }
    
    // MARK: - WeatherRepository
    func fetchCurrentWeather(
        lat: Double,
        lon: Double
    ) async throws -> Weather {
        let dto = try await api.fetchCurrent(lat: lat, lon: lon)
        return WeatherMapper.map(dto: dto)
    }
    
    func fetchForecast(
        lat: Double,
        lon: Double
    ) async throws -> [ForecastDay] {
        let dto = try await api.fetchForecast(lat: lat, lon: lon)
        return ForecastMapper.map(dto: dto)
    }
}
