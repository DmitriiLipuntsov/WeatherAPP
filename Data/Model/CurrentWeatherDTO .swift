//
//  CurrentWeatherDTO .swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation

public struct CurrentWeatherDTO: Decodable {
    public let location: LocationDTO
    public let current: CurrentDTO
}

public struct LocationDTO: Decodable {
    public let name: String
    public let lat: Double
    public let lon: Double
}

public struct CurrentDTO: Decodable {
    public let tempC: Double
    public let humidity: Int
    public let condition: ConditionDTO
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case humidity
        case condition
    }
}

public struct ConditionDTO: Decodable {
    public let text: String
    public let icon: String
}
