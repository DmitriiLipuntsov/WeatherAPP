//
//  LocationError.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 24.02.2026.
//

import Foundation

enum LocationError: Error {
    case permissionDenied
    case temporaryFailure
    case system(Error)
}
