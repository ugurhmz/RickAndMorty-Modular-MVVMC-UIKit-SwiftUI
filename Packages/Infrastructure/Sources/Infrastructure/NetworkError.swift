//
//  NetworkError.swift
//  Infrastructure
//
//  Created by rico on 14.01.2026.
//

import Foundation

public enum NetworkError: Error {
    
    // MARK: - Request Errors
    case invalidURL
    case invalidRequest
    case missingParameters
    
    // MARK: - Connectivity Errors
    case noInternet
    case networkConnectionLost
    case timeout
    
    // MARK: - HTTP / Server Errors
    case unauthorized            // 401
    case forbidden               // 403
    case notFound                // 404
    case conflict                // 409
    case serverError(code: Int, message: String?)
    
    // MARK: - Data / Decoding Errors
    case emptyResponse
    case decodingFailed
    case mappingFailed
    
    // MARK: - System Errors
    case cancelled
    case sslError
    case unknown(Error?)
}


public extension NetworkError {
    
    var userMessage: String {
        switch self {
        case .noInternet:
            return "Please check your internet connection."
        case .timeout:
            return "The request timed out."
        case .unauthorized:
            return "Your session has expired. Please sign in again."
        case .serverError(_, let message):
            return message ?? "A server error occurred."
        case .decodingFailed:
            return "A technical error occurred while processing the data."
        default:
            return "Something went wrong. Please try again."
        }
    }
    
    var debugMessage: String {
        switch self {
        case .serverError(let code, let message):
            return "Server error - Code: \(code), Message: \(message ?? "-")"
        case .unknown(let error):
            return "Unknown error: \(error?.localizedDescription ?? "-")"
        case .decodingFailed:
            return "Data could not be decoded to target model."
        default:
            return String(describing: self)
        }
    }
}

public extension NetworkError {
    
    static func from(statusCode: Int, message: String? = nil) -> NetworkError {
        switch statusCode {
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 409: return .conflict
        case 500...599: return .serverError(code: statusCode, message: message)
        default: return .unknown(nil)
        }
    }
    
    static func map(_ error: Error) -> NetworkError {
        let nsError = error as NSError
        
        if nsError.domain == NSURLErrorDomain {
            switch nsError.code {
            case NSURLErrorNotConnectedToInternet: return .noInternet
            case NSURLErrorTimedOut: return .timeout
            case NSURLErrorCancelled: return .cancelled
            case NSURLErrorNetworkConnectionLost: return .networkConnectionLost
            default: break
            }
        }
        
        return .unknown(error)
    }
}
