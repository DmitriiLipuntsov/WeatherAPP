//
//  Weather.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation

public struct Weather {
    public let city: String
    public let temperature: Double
    public let condition: String
    public let iconURL: URL?
    public let humidity: Int
}
