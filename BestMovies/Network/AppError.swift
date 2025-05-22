//
//  AppError.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

enum AppError: Error, Equatable {
    case network
    case decoding
    case noData
    case timeout
    case unknown
    case custom(message: String)
    
    static func == (lhs: AppError, rhs: AppError) -> Bool {
        switch (lhs, rhs) {
        case (.network, .network),
            (.decoding, .decoding),
            (.noData, .noData),
            (.timeout, .timeout),
            (.unknown, .unknown):
            return true
        case let (.custom(message1), .custom(message2)):
            return message1 == message2
        default:
            return false
        }
    }
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .network:
            return "Network connection error"
        case .decoding:
            return "Data decoding failed"
        case .noData:
            return "No data received from the server"
        case .timeout:
            return "The request timed out. Please try again."
        case .unknown:
            return "Unknown error occurred"
        case let .custom(message):
            return message
        }
    }
}
