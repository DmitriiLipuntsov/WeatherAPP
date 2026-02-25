//
//  NetworkMonitor.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private var isMonitoring = false
    var isConnected: Bool { monitor.currentPath.status == .satisfied }
    var usesVPN: Bool { monitor.currentPath.isExpensive }

    private init() {}

    func startMonitoring() {
        guard !isMonitoring else { return }
        monitor.start(queue: DispatchQueue.global(qos: .background))
        isMonitoring = true
    }

    func stopMonitoring() {
        monitor.cancel()
        isMonitoring = false
    }
}
