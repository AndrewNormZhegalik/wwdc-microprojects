// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

actor Debouncer {
    let delay: TimeInterval
    let sleep: (TimeInterval) async throws -> Void
    var task: Task<Void, Never>?
    
    init(
        delay: TimeInterval,
        sleep: @escaping (TimeInterval) async throws -> Void = {
            try await Task.sleep(for: .seconds(delay))
        }
    ) {
        self.delay = delay
        self.sleep = sleep
    }
    
    func schedule(_ operation: @escaping @Sendable () async -> Void) {
        task?.cancel()
        
        task = Task {
            do {
                try await sleep(delay)
                await operation()
            } catch {
                return
            }
        }
    }
    
    func cancel() {
        task?.cancel()
    }
}
