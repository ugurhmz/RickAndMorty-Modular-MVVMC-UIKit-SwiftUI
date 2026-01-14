//
//  NetworkTypes.swift
//  Infrastructure
//
//  Created by rico on 14.01.2026.
//

import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum RequestEncoding {
    case url
    case json
}

public typealias RequestParameters = [String: Any]

public enum NetworkTask {
    case requestPlain
    case requestParameters(parameters: RequestParameters,
                           encoding:RequestEncoding)
}

public struct EmptyResponse: Decodable {
    public init() {}
}
