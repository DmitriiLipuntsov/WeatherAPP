//
//  AppSettingsHelper.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 24.02.2026.
//

import UIKit

final class AppSettingsHelper {
    static func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
