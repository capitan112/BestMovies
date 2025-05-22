//
//  URL+QueryItems.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

extension URL {
    func url(with queryItems: [URLQueryItem]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        components.queryItems = (components.queryItems ?? []) + queryItems
        return components.url!
    }

    init<T>(_ host: String, _ apiKey: String, _ request: Request<T>) {
        let queryItems = [("api_key", apiKey)]
            .map { name, value in URLQueryItem(name: name, value: "\(value)") }

        let url = URL(string: host)!
            .appendingPathComponent(request.path)
            .url(with: queryItems)

        self.init(string: url.absoluteString)!
    }
}
