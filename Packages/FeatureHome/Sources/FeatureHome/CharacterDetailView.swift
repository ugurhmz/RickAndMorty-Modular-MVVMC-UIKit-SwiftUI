//
//  SwiftUIView.swift
//  FeatureHome
//
//  Created by rico on 22.01.2026.
//

import SwiftUI
import Domain

public struct CharacterDetailView: View {
    let character: Character
    
    public init(character: Character) {
        self.character = character
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                .cornerRadius(12)
                
                Text(character.name)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .accessibilityIdentifier("detail_character_name")
            }
        }
        .accessibilityIdentifier("detail_view")
    }
}
