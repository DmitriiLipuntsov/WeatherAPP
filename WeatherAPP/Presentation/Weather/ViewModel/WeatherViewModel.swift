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
    private(set) var locationBannerState: LocationBannerState = .none {
        didSet { onLocationDenied?(locationBannerState) }
    }
    
    var onStateChange: ((WeatherViewState) -> Void)?
    var onLocationDenied: ((LocationBannerState) -> Void)?
    
    // MARK: - Dependencies
    private let weatherUseCase: GetWeatherUseCase
    private let locationUseCase: GetUserLocationUseCase
    private var lifecycleService: AppLifecycleObserving
    
    // MARK: - Initializer
    init(
        weatherUseCase: GetWeatherUseCase,
        locationUseCase: GetUserLocationUseCase,
        lifecycleService: AppLifecycleObserving
    ) {
        self.weatherUseCase = weatherUseCase
        self.locationUseCase = locationUseCase
        self.lifecycleService = lifecycleService
        self.lifecycleService.onDidBecomeActive = { [weak self] in
            self?.handleAppDidBecomeActive()
        }
        requestWeatherWithLocation()
    }
}

// MARK: - Error
extension WeatherViewModel {
    private func mapError(_ error: Error) -> String {
        let apiError: APIError

        if let e = error as? APIError {
            apiError = e
        } else {
            apiError = APIError.network(hint: "Unknown network error.")
        }

        return apiError.errorDescription ?? "Unable to load weather data. Please try again."
    }
}

// MARK: - Location
extension WeatherViewModel {
    func requestWeatherWithLocation() {
        state = .loading
        locationBannerState = .none
        
        locationUseCase.execute { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let coordinate):
                self.loadWeather(lat: coordinate.lat, lon: coordinate.lon)
            case .failure(.permissionDenied):
                locationBannerState = .denied
                self.loadWeather()
            case .failure(.temporaryFailure):
                self.loadWeather()
            case .failure(.system(let err)):
                state = .error("GPS error: \(err.localizedDescription)")
            }
            
        }
    }
}

// MARK: - Weather API
extension WeatherViewModel {
    func loadWeather(
        lat: Double = Coordinate.moscow().lat,
        lon: Double = Coordinate.moscow().lon
    ) {
        state = .loading
        
        Task {
            do {
                let result = try await weatherUseCase.execute(
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

@MainActor
extension WeatherViewModel {
    func handleGrantLocationAccessTapped() {
        AppSettingsHelper.openAppSettings()
    }
}

extension WeatherViewModel {
    private func handleAppDidBecomeActive() {
        requestWeatherWithLocation()
    }
}
