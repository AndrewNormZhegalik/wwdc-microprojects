//
//  ContentView.swift
//  swift-performance
//
//  Created by Andrey on 20.07.2026.
//

import SwiftUI

class Person {
    let age: Int
    
    init(age: Int) {
        self.age = age
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Run Struct Benchmark") {
                runStructBenchmark()
            }
        }
        .padding()
    }
    
    func runStructBenchmark() {
        benchmark("Struct") {

            let dog = Dog(value: Int.random(in: 1...100))

            var sum = 0

            for _ in 0..<10_000_000 {
                sum += dog.bark()
            }

            print(sum)
        }
        checkCow()
    }
    
    func checkCoW() {
        var original = Array(0..<1_000_000)
        var copy = original // O(1) instead of O(n)
        
        original.withUnsafeBufferPointer { print("original: ", $0.baseAddress!) }
        copy.withUnsafeBufferPointer { print("copy: ", $0.baseAddress!) }
        
        copy.append(1) // O(n) because we allocate new buffer when mutating
        
        print("After change")
        original.withUnsafeBufferPointer { print("original: ", $0.baseAddress!) }
        copy.withUnsafeBufferPointer { print("copy: ", $0.baseAddress!) }
    }
}

#Preview {
    ContentView()
}
