//
//  Coordinator.swift
//  Core
//
//  Created by rico on 22.01.2026.
//

import UIKit

@MainActor
public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
