//
//  Endpoint.swift
//  Infrastructure
//
//  Created by rico on 14.01.2026.
//

import Foundation

public protocol Endpoint: Sendable {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var headers: [String: String]? { get }
    var task: NetworkTask { get }
}

public extension Endpoint {
    var baseURL: String {
        return "https://rickandmortyapi.com/api"
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json", "Accept": "application/json"]
    }
    
    var method: RequestMethod { .get }
    var task: NetworkTask { .requestPlain }
}
