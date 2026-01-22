//
//  AppConfigurator.swift
//  RickAndMortyHybrid
//
//  Created by rico on 22.01.2026.
//

import Foundation
import Core
import Infrastructure
import Data
import Domain

final class AppConfigurator {
    static let shared = AppConfigurator()
    
    private init() {}
    
    func configure() {
        print("AppConfigurator: Dependencies installing. ..")
        let networkManager = NetworkManager()
        let characterRepository = CharacterRepository(networkManager: networkManager)
        ServiceLocator.shared.register(characterRepository as CharacterRepositoryProtocol)
    }
}
