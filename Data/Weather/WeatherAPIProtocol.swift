//
//  WeatherAPIProtocol.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import Foundation

protocol WeatherAPIProtocol {
    func fetchCurrent(lat: Double, lon: Double) async throws -> CurrentWeatherDTO
    func fetchForecast(lat: Double, lon: Double) async throws -> ForecastDTO
}
