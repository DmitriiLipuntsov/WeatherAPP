//
//  ForecastMapper.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation

enum ForecastMapper {
    static func map(dto: ForecastDTO) -> [ForecastDay] {
        dto.forecast.forecastday.map { dayDTO in
            ForecastDay(
                date: parseDate(dayDTO.date),
                minTemperature: dayDTO.day.mintempC,
                maxTemperature: dayDTO.day.maxtempC,
                condition: dayDTO.day.condition.text,
                iconURL: APIURLNormalizer.normalizeIconPath(dayDTO.day.condition.icon),
                hours: mapHours(dayDTO.hour)
            )
        }
    }
}

private extension ForecastMapper {
    static func mapHours(_ dtos: [HourDTO]) -> [HourWeather] {
        dtos.map {
            HourWeather(
                date: parseDateTime($0.time),
                temperature: $0.tempC,
                condition: $0.condition.text,
                iconURL: APIURLNormalizer.normalizeIconPath($0.condition.icon)
            )
        }
    }
}

private extension ForecastMapper {
    static func parseDate(_ string: String) -> Date {
        return DateFormatterFactory.dayFormatter.date(from: string) ?? Date()
    }

    static func parseDateTime(_ string: String) -> Date {
        return DateFormatterFactory.hourFormatter.date(from: string) ?? Date()
    }
}
