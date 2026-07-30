//
//  Untitled.swift
//  TestRevolutSecondAttempt
//
//  Created by Andrey on 29.07.2026.
//

import Foundation

actor LocalCache {
    var storage: [String: Any] = [:]
    
    func save(_ key: String, _ value: Any) {
        storage[key] = value
    }
    
    func get(_ key: String) -> Any? {
        storage[key]
    }
}
