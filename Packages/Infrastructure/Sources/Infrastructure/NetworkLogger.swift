//
//  File.swift
//  Infrastructure
//
//  Created by rico on 14.01.2026.
//

import Foundation
import Alamofire

public final class NetworkLogger: EventMonitor {
    
    public let queue = DispatchQueue(label: "network.logger.queue")
    
    public init() {}
    
    public func request(_ request: Request, didCreateURLRequest urlRequest: URLRequest) {
        
        let method = urlRequest.httpMethod ?? "UNKNOWN"
        let url = urlRequest.url?.absoluteString ?? "NO URL"
        
        print("""
        
        🌍 ===============================
        REQUEST -> \(method) \(url)
        """)
        
        if let headers = urlRequest.allHTTPHeaderFields, !headers.isEmpty {
            print("🧾 Headers:")
            headers.forEach { print("   \($0): \($1)") }
        }
        
        if let body = urlRequest.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("Body:")
            print("   \(bodyString)")
        }
    }
    
    public func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        let method = request.request?.httpMethod ?? "UNKNOWN"
        let url = request.request?.url?.absoluteString ?? "NO URL"
        
        print("""
        
        ===============================
        RESPONSE -> \(method) \(url)
        """)
        
        if let statusCode = response.response?.statusCode {
            let icon = (200...299).contains(statusCode) ? "✅" : "❌"
            print("Status Code: \(statusCode) \(icon)")
        }
        
        if let data = response.data {
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                print("Response Body (JSON):")
                print(prettyString)
            } else if let responseString = String(data: data, encoding: .utf8) {
                print("Response Body (Raw):")
                print("   \(responseString)")
            }
        }
        
        if let error = response.error {
            print("🔴 Error: \(error.localizedDescription)")
        }
        
        print("===============================")
    }
}
