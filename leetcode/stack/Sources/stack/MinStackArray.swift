//
//  Untitled.swift
//  stack
//
//  Created by Andrey on 22.07.2026.
//

class MinStackArray {
    var storage: [(value: Int, minimal: Int)]

    init() {
        storage = []
    }
    
    func push(_ value: Int) {
        if storage.isEmpty {
            storage.append((value: value, minimal: value))
        } else {
            let newMin = storage.last!.minimal
            storage.append((value: value, minimal: min(newMin, value)))
        }
    }
    
    func pop() {
        _ = storage.removeLast()
    }
    
    func top() -> Int {
        storage.last!.value
    }
    
    func getMin() -> Int {
        storage.last!.minimal
    }
}
