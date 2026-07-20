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
    }
}

#Preview {
    ContentView()
}
