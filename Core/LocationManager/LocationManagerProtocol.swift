//
//  LocationManagerProtocol.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 24.02.2026.
//

import Foundation
import CoreLocation

// MARK: - LocationManager Protocol
protocol LocationManagerProtocol {
    func requestLocation(
          completion: @escaping (Result<CLLocation, LocationError>) -> Void
      )
}
