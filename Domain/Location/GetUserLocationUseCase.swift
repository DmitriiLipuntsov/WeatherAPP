//
//  GetUserLocationUseCase.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation

@MainActor
protocol GetUserLocationUseCase {
    func execute(
        completion: @escaping (Result<Coordinate, LocationError>) -> Void
    )
}

final class GetUserLocationUseCaseImpl: GetUserLocationUseCase {
    
    private let repository: LocationRepository
    
    init(repository: LocationRepository) {
        self.repository = repository
    }
    
    func execute(
        completion: @escaping (Result<Coordinate, LocationError>) -> Void
    ) {
        repository.getUserCoordinate { result in
            switch result {
            case .success(let coordinate):
                completion(.success(coordinate))
                
            case .failure(let error):
                switch error {
                case .permissionDenied:
                    completion(.failure(.permissionDenied))
                case .temporaryFailure:
                    completion(.failure(.temporaryFailure))
                case .system(let err):
                    completion(.failure(.system(err)))
                }
            }
        }
    }
}
