//
//  Coordinator.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 21.02.2026.
//

import UIKit

final class AppCoordinator: AppCoordinatorProtocol {
    
    // MARK: - Public Properties
    /// Root navigation controller of the application.
    /// Stored for future navigation flows if needed.
    private(set) var navigationController: UINavigationController?
    
    // MARK: - Dependencies
    private let window: UIWindow
    private let moduleBuilder: AssemblyModuleBuilderProtocol
    private let preloaderService: PreloaderServiceProtocol
    
    // MARK: - Initializer
    init(
        window: UIWindow,
        moduleBuilder: AssemblyModuleBuilderProtocol,
        preloaderService: PreloaderServiceProtocol
    ) {
        self.window = window
        self.moduleBuilder = moduleBuilder
        self.preloaderService = preloaderService
    }
}

// MARK: - Lifecycle
extension AppCoordinator {
    /// Starts the application flow.
    /// Displays launch screen and triggers preloading sequence.
    func start() {
        showLaunchScreen()
        
        Task {
            await handlePreloading()
        }
    }
}

// MARK: - Launch Flow
private extension AppCoordinator {
    /// Displays the launch screen as the root controller.
    func showLaunchScreen() {
        let launchVC = moduleBuilder.createVC(.launch, coordinator: self)
        window.rootViewController = launchVC
        window.makeKeyAndVisible()
    }
    
    /// Handles async preloading logic before entering main flow.
    private func handlePreloading() async {
        do {
            try await preloaderService.preload()
            showMainFlow()
        } catch {
            LoggerManager.error(
                error.localizedDescription,
                category: .data
            )
            showMainFlow()
        }
    }
    
    /// Transitions to the main weather flow.
    func showMainFlow() {
        let weatherVC = moduleBuilder.createVC(.weather, coordinator: self)
        let navigationController = UINavigationController(rootViewController: weatherVC)
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
        window.rootViewController = navigationController
        
        UIView.transition(
            with: window,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: nil
        )
    }
}
