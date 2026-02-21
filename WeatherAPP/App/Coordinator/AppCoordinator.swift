//
//  Coordinator.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 21.02.2026.
//

import UIKit

final class AppCoordinator: AppCoordinatorProtocol {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        showWeather(on: navigationController)
    }

    private func showWeather(on navigationController: UINavigationController) {
        let viewController = WeatherViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
}
