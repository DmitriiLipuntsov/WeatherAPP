//
//  WeatherRepository.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func fetchCurrentWeather(
        lat: Double,
        lon: Double
    ) async throws -> Weather
    
    func fetchForecast(
        lat: Double,
        lon: Double
    ) async throws -> [ForecastDay]
}
