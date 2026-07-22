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

//class Ref<T> {
//    var value: T
//    init(value: T) {
//        self.value = value
//    }
//}
//
//struct Box<T> {
//    var ref: Ref<T>
//    init(value: T) {
//        self.value = Ref(value)
//    }
//    
//    var value {
//        get {
//            return ref.value
//        }
//        set {
//            if !isKnownUniquelyReferenced(&ref) {
//                ref = Ref(newValue)
//                return
//            }
//            
//            ref.value = value
//        }
//    }
//}



class Reference<T> {
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
}

struct Box<T> {
    var reference: Reference<T>
    
    var value: T {
        get {
            reference.value
        } set {
            if isKnownUniquelyReferenced(&reference) {
                reference.value = newValue
            } else {
                reference = Reference(newValue)
            }
        }
    }
}
