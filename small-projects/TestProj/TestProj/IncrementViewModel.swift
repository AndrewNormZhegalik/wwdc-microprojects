//
//  Untitled.swift
//  TestProj
//
//  Created by Andrey on 30.07.2026.
//

import Combine

@MainActor
public class IncrementViewModel: ObservableObject {
    @Published var value: Int = 0

    func increment() {
        value += 1
    }
    
    func decrement() {
        value -= 1
    }
    
    func getValue() {
        Task {
            value = await loadValue()
        }
    }
    
    private func loadValue() async -> Int {
        try? await Task.sleep(for: .milliseconds(300))
        return Int.random(in: 1...100)
    }
}
