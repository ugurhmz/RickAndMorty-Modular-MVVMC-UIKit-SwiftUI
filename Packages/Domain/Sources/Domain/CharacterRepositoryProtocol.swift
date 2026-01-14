//
//  File.swift
//  Domain
//
//  Created by rico on 14.01.2026.
//

import Foundation

public protocol CharacterRepositoryProtocol: Sendable {
    func fetchCharacters() async throws -> [Character]
}
