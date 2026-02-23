//
//  AssemblyModuleBuilder.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 21.02.2026.
//

import UIKit

class AssemblyModuleBuilder: AssemblyModuleBuilderProtocol {
    // MARK: - Public Factory
    func createVC(_ type: MapRouter, coordinator: AppCoordinatorProtocol) -> UIViewController {
        switch type {
        case .launch:
            return createLaunchModule(coordinator: coordinator)
        case .weather:
            return createWeatherModule(coordinator: coordinator)
        }
    }
}

// MARK: - Module Creation
extension AssemblyModuleBuilder {
    private func createLaunchModule(coordinator: AppCoordinatorProtocol) -> UIViewController {
        let vc = LaunchScreenViewController()
        return vc
    }
    
    private func createWeatherModule(coordinator: AppCoordinatorProtocol) -> UIViewController {
        let vc = WeatherAssembly.build()
        return vc
    }
}

