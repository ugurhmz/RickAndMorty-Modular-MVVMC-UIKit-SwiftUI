//
//  CharactersEndpoint.swift
//  Data
//
//  Created by rico on 22.01.2026.
//

import Foundation
import Infrastructure

enum CharactersEndpoint: Endpoint {
    case getAll
}

extension CharactersEndpoint {
    var path: String {
        switch self {
        case .getAll:
            return "/character"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAll:
            return .get
        }
    }
}
