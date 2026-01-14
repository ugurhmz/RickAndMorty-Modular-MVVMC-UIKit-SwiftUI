//
//  Inject.swift
//  Core
//
//  Created by rico on 14.01.2026.
//

import Foundation

@propertyWrapper
public struct Inject<T> {
    
    public var wrappedValue: T {
        get { ServiceLocator.shared.resolve() }
    }
    
    public init() {}
}
