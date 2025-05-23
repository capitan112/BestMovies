//
//  Genres.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

struct Genres: Decodable {
    let genres: [Genre]
}

// MARK: - Genre

struct Genre: Codable {
    let id: Int
    let name: String
}

extension Genres {
    static func genresRequest() -> Request<Genres> {
        return Request(method: .get, path: "genre/movie/list", parameters: [:])
    }
}

enum GenreMapping {
    private static var idToName: [Int: String] = [:]

    static func update(with genres: [Genre]) {
        idToName = Dictionary(uniqueKeysWithValues: genres.map { ($0.id, $0.name) })
    }

    static func convertGenreIdsToString(_ ids: [Int]) -> String {
        ids.compactMap { idToName[$0] }.joined(separator: ", ")
    }
}
