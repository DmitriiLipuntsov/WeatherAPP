//
//  ForecastDTO.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation

public struct ForecastDTO: Decodable {
    public let forecast: ForecastContainerDTO
}

public struct ForecastContainerDTO: Decodable {
    public let forecastday: [ForecastDayDTO]
}

public struct ForecastDayDTO: Decodable {
    public let date: String
    public let day: DayDTO
    public let hour: [HourDTO]
}

public struct DayDTO: Decodable {
    public let maxtempC: Double
    public let mintempC: Double
    public let condition: ConditionDTO
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
    }
}

public struct HourDTO: Decodable {
    public let time: String
    public let tempC: Double
    public let condition: ConditionDTO
    
    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
    }
}
