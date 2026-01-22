//
//  HomeView.swift
//  FeatureHome
//
//  Created by rico on 22.01.2026.
//

import SwiftUI
import Domain
import Core

public struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView("Loading...")
                    .scaleEffect(1.7)
                    .accessibilityIdentifier("loading_indicator")
            case .success(let characters):
                List(characters) { character in
                    Button {
                        viewModel.didSelect(character: character)
                    } label: {
                        HStack {
                            AsyncImage(url: URL(string: character.image)) { img in
                                img.resizable()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            
                            Text(character.name)
                                .font(.headline)
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                    }
                    .accessibilityIdentifier("row_\(character.name)")
                }
                .listStyle(.plain)
                .accessibilityIdentifier("character_list")
            case .failure(let error):
                Text(error).foregroundStyle(.red)
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
    let vm = HomeViewModel()
    return HomeView(viewModel: vm)
}

fileprivate class MockCharacterRepository: CharacterRepositoryProtocol, @unchecked Sendable {
    func fetchCharacters() async throws -> [Domain.Character] {
        return [
            Character(id: 1, name: "Rick Sanchez", status: .alive, species: "Human", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
            Character(id: 2, name: "Morty Smith", status: .alive, species: "Human", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
        ]
    }
}
