//
//  NetworkClient.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

protocol NetworkClientProtocol {
    func execute<T: Decodable>(_ request: Request<T>, completion: @escaping (Result<T, APIError>) -> Void)
}

final class NetworkClient: NetworkClientProtocol {
    private let host: String
    private let apiKey: String
    private let session: URLSession

    init(host: String, apiKey: String, session: URLSession = .shared) {
        self.host = host
        self.apiKey = apiKey
        self.session = session
    }

    func execute<T: Decodable>(_ request: Request<T>, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = session.dataTask(with: urlRequest(for: request)) { data, _, error in
            guard error == nil else {
                if let urlError = error as? URLError {
                    switch urlError.code {
                    case .timedOut:
                        completion(.failure(.timeout))
                    case .networkConnectionLost:
                        completion(.failure(.connectionLost))
                    default:
                        completion(.failure(.networkError))
                    }
                } else {
                    completion(.failure(.networkError))
                }
                return
            }


            guard let data = data else {
                completion(.failure(.networkError))
                return
            }

            do {
                let value = try JSONDecoder().decode(T.self, from: data)
                completion(.success(value))
            } catch {
                completion(.failure(.parsingError))
            }
        }
        task.resume()
    }

    private func urlRequest<T>(for request: Request<T>) -> URLRequest {
        let url = URL(host, apiKey, request)
        var result = URLRequest(url: url)
        result.httpMethod = request.method.rawValue
        result.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        result.timeoutInterval = 10
        return result
    }
}
