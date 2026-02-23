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
        let repository = WeatherRepositoryImpl(api: api)
        let useCase = GetWeatherUseCase(repository: repository)
        let viewModel = WeatherViewModel(useCase: useCase)
        let viewController = WeatherViewController(viewModel: viewModel)
        return viewController
    }
}
