//
//  CharacterRepository.swift
//  Data
//
//  Created by rico on 22.01.2026.
//

import Foundation
import Domain
import Infrastructure

public final class CharacterRepository: CharacterRepositoryProtocol, @unchecked Sendable {
    
    private let networkManager: NetworkServiceProtocol
    
    public init(networkManager: NetworkServiceProtocol) {
        self.networkManager = networkManager
    }
    
    public func fetchCharacters() async throws -> [Character] {
        let endpoint = CharactersEndpoint.getAll
        let response = try await networkManager.request(endpoint, type: CharacterResponse.self)
        
        return response.results
    }
}
