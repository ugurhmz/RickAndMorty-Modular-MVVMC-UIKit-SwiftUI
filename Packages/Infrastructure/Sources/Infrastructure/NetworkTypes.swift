//
//  NetworkTypes.swift
//  Infrastructure
//
//  Created by rico on 14.01.2026.
//

import Foundation

public enum RequestMethod: String, Sendable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum RequestEncoding: Sendable {
    case url
    case json
}

public struct RequestParameters: @unchecked Sendable {
    public let value: [String: Any]
    
    public init(_ value: [String: Any]) {
        self.value = value
    }
}

public enum NetworkTask: Sendable {
    case requestPlain
    case requestParameters(parameters: RequestParameters, encoding: RequestEncoding)
}

public struct EmptyResponse: Decodable, Sendable {
    public init() {}
}
