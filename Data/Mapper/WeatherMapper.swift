//
//  WeatherMapper.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation

enum WeatherMapper {
    static func map(dto: CurrentWeatherDTO) -> Weather {
        Weather(
            city: dto.location.name,
            temperature: dto.current.tempC,
            condition: dto.current.condition.text,
            iconURL: APIURLNormalizer.normalizeIconPath(dto.current.condition.icon),
            humidity: dto.current.humidity
        )
    }
}
