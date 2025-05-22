//
//  Request.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

enum Method: String {
    case get = "GET"
}

struct Request<Value> {
    var method: Method
    var path: String
    var queryParams: [String: String]

    init(method: Method = .get, path: String, parameters: [String: String] = [:]) {
        self.method = method
        self.path = path
        queryParams = parameters
    }
}

import Foundation
