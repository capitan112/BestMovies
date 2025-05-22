//
//  APIError.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

enum APIError: Error {
    case networkError
    case parsingError
    case timeout
    case connectionLost
    case noData
}


extension APIError {
    func toAppError() -> AppError {
        switch self {
        case .networkError, .connectionLost:
            return .network
        case .timeout:
            return .timeout
        case .parsingError:
            return .decoding
        case .noData:
            return .noData
        }
    }
}
