//
//  ServiceLocator.swift
//  Core
//
//  Created by rico on 14.01.2026.
//

import Foundation

public final class ServiceLocator: @unchecked Sendable {
    
    public static let shared = ServiceLocator()
    private var services: [String: Any] = [:]
    
    private let lock = NSRecursiveLock()
    
    private init() {}
    
    public func register<T>(_ service: T) {
        lock.lock()
        defer { lock.unlock() }
        
        let key = String(describing: T.self)
        services[key] = service
        print("[ServiceLocator] Registered: \(key)")
    }
    
    public func resolve<T>() -> T {
        lock.lock()
        defer { lock.unlock() }
        
        let key = String(describing: T.self)
        
        guard let service = services[key] as? T else {
            fatalError("[ServiceLocator] Service not found: \(key). Check the AppConfigurator")
        }
        
        return service
    }
    
    public func unregisterAll() {
        lock.lock()
        defer { lock.unlock() }
        services.removeAll()
    }
}
