//
//  Coordinate.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation

struct Coordinate: Equatable {
    let lat: Double
    let lon: Double

    nonisolated static func moscow() -> Coordinate {
        Coordinate(lat: 55.7558, lon: 37.6173)
    }
}
