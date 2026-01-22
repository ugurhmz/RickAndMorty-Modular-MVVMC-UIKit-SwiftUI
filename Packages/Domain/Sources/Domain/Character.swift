//
//  Character.swift
//  Domain
//
//  Created by rico on 14.01.2026.
//

import Foundation

public struct Character: Decodable, Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let gender: String
    public let image: String
    
    public init(id: Int, name: String, status: String, species: String, gender: String, image: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.image = image
    }
}

public struct CharacterResponse: Decodable, Sendable {
    public let results: [Character]
    
    public init(results: [Character]) {
        self.results = results
    }
}
