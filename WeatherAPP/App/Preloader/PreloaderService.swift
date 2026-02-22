//
//  PreloaderService.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import Foundation

protocol PreloaderServiceProtocol {
    func preload() async throws
}

final class PreloaderService: PreloaderServiceProtocol {
    // MARK: - Public API
    
    /// Executes required startup tasks.
    /// Can include:
    /// - Remote config fetch
    /// - Initial data warm-up
    /// - Token validation
    /// - Database migrations
    func preload() async throws {
        
        LoggerManager.info(
            "Preloading started",
            category: .data
        )
        
        // Simulate async warm-up task
        try await Task.sleep(nanoseconds: 500_000_000)
        
        LoggerManager.info(
            "Preloading completed",
            category: .data
        )
    }
}
