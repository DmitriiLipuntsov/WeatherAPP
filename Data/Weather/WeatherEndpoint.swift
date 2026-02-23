//
//  WeatherEndpoint.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation

enum WeatherEndpoint: Endpoint {
    
    case current(lat: Double, lon: Double)
    case forecast(lat: Double, lon: Double, days: Int)
    
    // MARK: - Endpoint
    
    var baseURL: String {
        "http://api.weatherapi.com/v1"
    }
    
    var path: String {
        switch self {
        case .current:
            return "/current.json"
            
        case .forecast:
            return "/forecast.json"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [URLQueryItem]? {
        
        var items: [URLQueryItem] = [
            URLQueryItem(name: "key", value: WeatherAPIKeys.key)
        ]
        
        switch self {
            
        case .current(let lat, let lon):
            items.append(
                URLQueryItem(name: "q", value: "\(lat),\(lon)")
            )
            
        case .forecast(let lat, let lon, let days):
            items.append(
                URLQueryItem(name: "q", value: "\(lat),\(lon)")
            )
            items.append(
                URLQueryItem(name: "days", value: "\(days)")
            )
        }
        
        return items
    }
    
    var headers: [String : String]? {
        [
            "Accept": "application/json"
        ]
    }
}
