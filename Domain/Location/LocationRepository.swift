//
//  LocationRepository.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation
import CoreLocation

protocol LocationRepository {
    func getUserCoordinate(
        completion: @escaping (Result<Coordinate, LocationError>) -> Void
    )
}

final class LocationRepositoryImpl: LocationRepository {

    private let locationManager: LocationManagerProtocol

    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
    }

    func getUserCoordinate(
        completion: @escaping (Result<Coordinate, LocationError>) -> Void
    ) {
        locationManager.requestLocation { result in
            switch result {
            case .success(let location):
                let coordinate = Coordinate(
                    lat: location.coordinate.latitude,
                    lon: location.coordinate.longitude
                )
                completion(.success(coordinate))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
