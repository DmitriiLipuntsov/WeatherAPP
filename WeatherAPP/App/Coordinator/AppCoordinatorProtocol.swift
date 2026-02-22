//
//  AppCoordinatorProtocol.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 21.02.2026.
//

import UIKit

protocol AppCoordinatorProtocol {
    var navigationController: UINavigationController? { get }
    
    func start()
    func show(_ route: MapRouter, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func dismiss(animated: Bool)
}

extension AppCoordinatorProtocol {
    func show(_ route: MapRouter, animated: Bool = true) {
        show(route, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        pop(animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        pop(animated: animated)
    }
    func dismiss(animated: Bool = true) {
        dismiss(animated: animated)
    }
}
