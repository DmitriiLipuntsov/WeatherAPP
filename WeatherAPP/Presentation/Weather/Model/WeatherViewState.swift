//
//  WeatherViewState.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import Foundation

enum WeatherViewState {
    case idle
    case loading
    case loaded(WeatherAggregate)
    case error(String)
}
