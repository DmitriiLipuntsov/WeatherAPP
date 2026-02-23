//
//  ForecastDay.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation

public struct ForecastDay {
    public let date: Date
    public let minTemperature: Double
    public let maxTemperature: Double
    public let condition: String
    public let iconURL: URL?
    public let hours: [HourWeather]
}
