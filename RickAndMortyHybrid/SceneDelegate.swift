//
//  SceneDelegate.swift
//  RickAndMortyHybrid
//
//  Created by rico on 14.01.2026.
//

import UIKit
import FeatureHome
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        AppConfigurator.shared.configure()
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
    
}

