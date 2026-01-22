//
//  AppCoordinator.swift
//  RickAndMortyHybrid
//
//  Created by rico on 22.01.2026.
//

import UIKit
import SwiftUI
import Core
import Domain
import FeatureHome

@MainActor
final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHomeScreen()
    }
    
    private func showHomeScreen() {
        let viewModel = HomeViewModel()
        
        viewModel.onDetailRequested = { [weak self] character in
            self?.showDetailScreen(character: character)
        }
        
        let homeView = HomeView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: homeView)
        hostingController.title = "Rick and Morty"
        navigationController.pushViewController(hostingController, animated: true)
    }
    
    private func showDetailScreen(character: Character) {
        let detailView = CharacterDetailView(character: character)
        let hostingController = UIHostingController(rootView: detailView)
        hostingController.title = character.name
        navigationController.pushViewController(hostingController, animated: true)
    }
}
