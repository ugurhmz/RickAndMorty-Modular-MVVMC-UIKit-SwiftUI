//
//  File.swift
//  HomeViewModel
//
//  Created by rico on 22.01.2026.
//

import Foundation
import Core
import Domain
import SwiftUI

@MainActor
public final class HomeViewModel: ObservableObject {
    
    @Published public var state: HomeViewState = .loading
    
    public var onDetailRequested: ((Character) -> Void)?
    
    @Inject private var repository: CharacterRepositoryProtocol
    
    public init() {}
    
    public func fetchCharacters() {
        state = .loading
        Task {
            do {
                let result = try await repository.fetchCharacters()
                if result.isEmpty {
                    state = .failure("Karakter listesi boş geldi.")
                } else {
                    state = .success(result)
                }
            } catch {
                state = .failure(error.localizedDescription)
            }
        }
    }
    
    // View'daki butona basılınca bu çalışır
    public func didSelect(character: Character) {
        // Coordinator'a "Patron, detay istendi" diye haber verir
        onDetailRequested?(character)
    }
}

extension CharacterStatusType {
    var color: Color {
        switch self {
        case .alive:
            return .green
        case .dead:
            return .red
        case .unknown:
            return .gray
        }
    }
    
    var iconName: String {
        switch self {
        case .alive: return "heart.fill"
        case .dead: return "heart.slash.fill"
        case .unknown: return "questionmark.circle"
        }
    }
}
