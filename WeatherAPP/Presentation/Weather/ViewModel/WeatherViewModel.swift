//
//  WeatherViewModel.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import Foundation

@MainActor
final class WeatherViewModel {
    
    // MARK: - Public Properties
    private(set) var state: WeatherViewState = .idle {
        didSet { onStateChange?(state) }
    }
    
    var onStateChange: ((WeatherViewState) -> Void)?
    
    // MARK: - Dependencies
    private let useCase: GetWeatherUseCase
    
    // MARK: - Initializer
    init(useCase: GetWeatherUseCase) {
        self.useCase = useCase
        loadWeather(lat: 55.7558, lon: 37.6173)
    }
    
    let client = NetworkClient()

    
}

extension WeatherViewModel {
    private func mapError(_ error: Error) -> String {
        return "Unable to load weather data. Please try again."
    }
}

// MARK: - Weather API
extension WeatherViewModel {
    func loadWeather(lat: Double, lon: Double) {
        state = .loading
        
        Task {
            do {
                let result = try await useCase.execute(
                    lat: lat,
                    lon: lon
                )
                state = .loaded(result)
            } catch {
                state = .error(mapError(error))
            }
        }
    }
}
