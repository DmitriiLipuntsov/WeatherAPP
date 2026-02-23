//
//  NetworkConfig.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import Foundation

public struct NetworkConfig {
    let timeout: TimeInterval
    let retryCount: Int
    
    public static let `default` = NetworkConfig(
        timeout: 15,
        retryCount: 2
    )
}
