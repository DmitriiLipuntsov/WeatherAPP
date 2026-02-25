//
//  LocationManager.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation
import CoreLocation

// MARK: - LocationManager
final class LocationManager: NSObject, CLLocationManagerDelegate, LocationManagerProtocol {

    private let manager = CLLocationManager()
    private var completion: ((Result<CLLocation, LocationError>) -> Void)?
    private var isUpdating = false
    private var didFinish = false
    private var timeoutTask: DispatchWorkItem?

    private let locationTimeout: TimeInterval = 10.0
    
    private var retryCount = 0
    private let maxRetry = 3

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func requestLocation(
        completion: @escaping (Result<CLLocation, LocationError>) -> Void
    ) {
        self.completion = completion
        didFinish = false

        switch manager.authorizationStatus {

        case .notDetermined:
            manager.requestWhenInUseAuthorization()

        case .restricted, .denied:
            finish(.failure(.permissionDenied))

        case .authorizedAlways, .authorizedWhenInUse:
            requestSingleLocation()

        @unknown default:
            finish(.failure(.system(NSError(domain: "UnknownAuthorization", code: -1))))
        }

        startTimeout()
    }
}

// MARK: - Private
private extension LocationManager {
    func requestSingleLocation() {
        isUpdating = true
        manager.requestLocation()
    }

    func finish(_ result: Result<CLLocation, LocationError>) {
        guard !didFinish else { return }

        didFinish = true
        timeoutTask?.cancel()
        timeoutTask = nil
        isUpdating = false
        completion?(result)
        completion = nil
    }

    func stopUpdatingIfNeeded() {
        if isUpdating {
            manager.stopUpdatingLocation()
            isUpdating = false
        }
    }

    private func startTimeout() {
        timeoutTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            self?.finish(.failure(.temporaryFailure))
        }
        timeoutTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + locationTimeout, execute: task)
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        finish(.success(location))
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

        guard !didFinish else { return }

        guard let clError = error as? CLError else {
            finish(.failure(.system(error)))
            return
        }

        switch clError.code {

        case .locationUnknown:
            if retryCount < maxRetry {
                retryCount += 1
                manager.startUpdatingLocation()
            } else {
                finish(.failure(.temporaryFailure))
            }

        case .denied:
            finish(.failure(.permissionDenied))

        default:
            finish(.failure(.system(clError)))
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        switch manager.authorizationStatus {

        case .authorizedAlways, .authorizedWhenInUse:
            if !didFinish {
                requestSingleLocation()
            }

        case .denied, .restricted:
            finish(.failure(.permissionDenied))

        default:
            break
        }
    }
}
