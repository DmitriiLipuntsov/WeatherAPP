//
//  AppLifecycleService.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 25.02.2026.
//

import Foundation
import UIKit

protocol AppLifecycleObserving {
    var onDidBecomeActive: (() -> Void)? { get set }
}

final class AppLifecycleService: AppLifecycleObserving {

    var onDidBecomeActive: (() -> Void)?

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }

    @objc private func didBecomeActive() {
        onDidBecomeActive?()
    }
}
