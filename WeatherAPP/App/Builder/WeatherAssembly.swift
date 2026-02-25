//
//  WeatherAssembly.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import UIKit

final class WeatherAssembly {
    static func build() -> UIViewController {
        let networkClient = NetworkClient()
        let api = WeatherAPI(networkClient: networkClient)
        let weatherRepository = WeatherRepositoryImpl(api: api)
        let weatherUseCase = GetWeatherUseCase(repository: weatherRepository)
        
        let locationManager = LocationManager()
        let locationRepository = LocationRepositoryImpl(locationManager: locationManager)
        let locationUseCase =  GetUserLocationUseCaseImpl(repository: locationRepository)
        
        let lifecycleService = AppLifecycleService()
        
        let viewModel = WeatherViewModel(
            weatherUseCase: weatherUseCase,
            locationUseCase: locationUseCase,
            lifecycleService: lifecycleService
        )
        let viewController = WeatherViewController(viewModel: viewModel)
        return viewController
    }
}
