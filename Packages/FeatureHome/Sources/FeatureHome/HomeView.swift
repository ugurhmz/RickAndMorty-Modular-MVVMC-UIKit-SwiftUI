//
//  HomeView.swift
//  FeatureHome
//
//  Created by rico on 22.01.2026.
//

import Foundation
import SwiftUI
import Domain
import Core

public struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    public init() {}
    
    public var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView("Characters loading...")
                    .scaleEffect(1.6)
                    .progressViewStyle(CircularProgressViewStyle(tint: .green))
            case .success(let characters):
                List(characters) { character in
                    HStack {
                        AsyncImage(url: URL(string: character.image)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .font(.headline)
                            HStack(spacing: 4) {
                                Image(systemName: character.status.iconName)
                                    .font(.caption)
                                Text(character.status.rawValue)
                                    .font(.subheadline)
                            }
                            .foregroundStyle(character.status.color)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
            case .failure(let errorMessage):
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Text(errorMessage)
                }
            }
        }
        .task {
            viewModel.fetchCharacters()
        }
        
    }
}

#Preview {
    let mockRepo = MockCharacterRepository()
    ServiceLocator.shared.register(mockRepo as CharacterRepositoryProtocol)
    
    return HomeView()
}


fileprivate class MockCharacterRepository: CharacterRepositoryProtocol, @unchecked Sendable {
    func fetchCharacters() async throws -> [Domain.Character] {
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        return [
            Character(id: 1, name: "Rick Sanchez", status: .alive, species: "Human", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
            Character(id: 2, name: "Morty Smith", status: .alive, species: "Human", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"),
            Character(id: 3, name: "Summer Smith", status: .dead, species: "Human", gender: "Female", image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg")
        ]
    }
}
