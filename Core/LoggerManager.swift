//
//  LoggerManager.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 22.02.2026.
//

import Foundation
import os

enum LoggerManager {

    private static let subsystem = Bundle.main.bundleIdentifier ?? "App"

    enum Category: String {
        case layout
        case network
        case repository
        case location
        case data
    }

    private static func logger(for category: Category) -> Logger {
        Logger(subsystem: subsystem, category: category.rawValue)
    }

    static func error(
        _ message: String,
        category: Category,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        logger(for: category).error("""
        ❌ \(message, privacy: .public)
        📍 \(file):\(line) \(function)
        """)
    }

    static func debug(
        _ message: String,
        category: Category,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        logger(for: category).debug("""
        🛠 \(message, privacy: .public)
        📍 \(file):\(line) \(function)
        """)
    }

    static func info(
        _ message: String,
        category: Category
    ) {
        logger(for: category).info("\(message, privacy: .public)")
    }
}
