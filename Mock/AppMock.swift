//
//  AppMock.swift
//  WeatherAPP
//
//  Created by Dmitry Lipuntsov on 23.02.2026.
//

import Foundation

struct TestEndpoint: Endpoint {
    var baseURL: String { "https://jsonplaceholder.typicode.com" }
    var path: String { "/todos/1" }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? { nil }
    var headers: [String : String]? { nil }
}

struct Todo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
