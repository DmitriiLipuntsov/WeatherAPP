//
//  AppMapRouter.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 21.02.2026.
//

import Foundation

enum NavigationTranisitionStyle {
    case push
    case presentModally
    case presentFullscreen
    case custom
}

enum MapRouter: String, Hashable, Identifiable {
    case launch
    case weather
    
    var id: String {
        return rawValue
    }
}
