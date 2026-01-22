//
//  File.swift
//  HomeViewModel
//
//  Created by rico on 22.01.2026.
//

import Foundation
import Domain
import Core

@MainActor
public final class HomeViewModel: ObservableObject {
    
    @Published public var state: HomeViewState = .loading
    
    @Inject private var repository: CharacterRepositoryProtocol
    
    public init(){}
    
    public func fetchCharacters() {
        state = .loading
        
        Task {
            do {
                let characters = try await repository.fetchCharacters()
                if characters.isEmpty {
                    state = .failure("Character List empty!")
                } else {
                    state = .success(characters)
                }
            } catch {
                state = .failure(error.localizedDescription)
            }
        }
    }
}
