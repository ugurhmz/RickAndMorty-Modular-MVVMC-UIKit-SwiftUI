//
//  NetworkManager.swift
//  Infrastructure
//
//  Created by rico on 14.01.2026.
//

//
//  NetworkManager.swift
//  Infrastructure
//
//  Created by rico on 14.01.2026.
//

import Foundation
@preconcurrency import Alamofire

public protocol NetworkServiceProtocol: Sendable {
    func request<T: Decodable>(_ endpoint: Endpoint, type: T.Type) async throws -> T
}

public final class NetworkManager: NetworkServiceProtocol, @unchecked Sendable {
    
    private let session: Session
    private let decoder: JSONDecoder
    
    public init(configuration: URLSessionConfiguration = .default) {
        configuration.timeoutIntervalForRequest = 30
        
        self.session = Session(
            configuration: configuration,
            eventMonitors: [NetworkLogger()]
        )
        
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    public func request<T: Decodable>(_ endpoint: Endpoint, type: T.Type) async throws -> T {
        guard let url = URL(string: endpoint.baseURL)?.appendingPathComponent(endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        let afMethod = HTTPMethod(rawValue: endpoint.method.rawValue)
        var parameters: Parameters? = nil
        let encoding: ParameterEncoding
        
        switch endpoint.task {
        case .requestPlain:
            parameters = nil
            encoding = URLEncoding.default
        case .requestParameters(let params, let enc):
            parameters = params.value
            encoding = (enc == .json) ? JSONEncoding.default : URLEncoding.default
        }
        
        let afHeaders = endpoint.headers.map { HTTPHeaders($0) }
        
        let request = session.request(
            url,
            method: afMethod,
            parameters: parameters,
            encoding: encoding,
            headers: afHeaders
        ).validate()
        
        let response = await request
            .serializingData()
            .response
        
        if let error = response.error {
            if response.response == nil {
                throw NetworkError.map(error)
            }
        }
        
        if let statusCode = response.response?.statusCode {
            if !(200...299).contains(statusCode) {
                let serverMessage = response.data.flatMap { String(data: $0, encoding: .utf8) }
                throw NetworkError.from(statusCode: statusCode, message: serverMessage)
            }
        }
        
        guard let data = response.data, !data.isEmpty else {
            if T.self == EmptyResponse.self {
                return EmptyResponse() as! T
            }
            throw NetworkError.emptyResponse
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            #if DEBUG
            print("Decoding Error Detail:", error)
            #endif
            throw NetworkError.decodingFailed
        }
    }
}
