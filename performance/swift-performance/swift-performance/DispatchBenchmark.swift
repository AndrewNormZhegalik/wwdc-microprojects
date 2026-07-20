//
//  Untitled.swift
//  swift-performance
//
//  Created by Andrey on 20.07.2026.
//

import Foundation

func benchmark(_ title: String, iterations: Int = 10, block: () -> Void) {
    let start = CFAbsoluteTimeGetCurrent()
    block()
    let end = CFAbsoluteTimeGetCurrent()
    
    print("\(title): \(end - start) seconds")
}

struct Dog {
    var value: Int
    
    func bark() -> Int {
        value
    }
}

protocol Animal {
    func bark() -> Int
}

struct Cat: Animal {
    func bark() -> Int {
        1
    }
}

class Lion {

    func roar() -> Int {
        1
    }

}

class Tiger: Lion {

    override func roar() -> Int {
        1
    }

}
