//
//  APIURLNormalizer.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation

enum APIURLNormalizer {
    static func normalizeIconPath(_ path: String) -> URL? {
        let urlString: String
        if path.hasPrefix("//") {
            urlString = "https:\(path)"
        } else {
            urlString = path
        }
        return URL(string: urlString)
    }
}
