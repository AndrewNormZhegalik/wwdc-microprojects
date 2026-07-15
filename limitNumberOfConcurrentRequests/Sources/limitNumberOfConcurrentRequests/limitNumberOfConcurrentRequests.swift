// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

final class ImageBatchLoader: Sendable {
    private let fetch: @Sendable (URL) async throws -> Data
    
    init(fetch: @escaping @Sendable (URL) async throws -> Data = { url in
        try await URLSession.shared.data(from: url).0
    }) {
        self.fetch = fetch
    }
    
    func loadImages(with urls: [URL], maxConcurrent: Int) async throws -> [(url: URL, data: Data)] {
        return try await withThrowingTaskGroup(of: (URL, Data).self) { group in
            var currentIndex: Int = 0
            let total = urls.count
            var result: [(url: URL, data: Data)] = []
            
            while currentIndex < min(maxConcurrent, total) {
                let url = urls[currentIndex]
                group.addTask {
                    let data = try await self.fetch(url)
                    return (url, data)
                }
                
                currentIndex += 1
            }
            
            for try await (url, data) in group {
                result.append((url, data))
                
                if currentIndex < total {
                    let url = urls[currentIndex]
                    group.addTask {
                        let data = try await self.fetch(url)
                        return (url, data)
                    }
                    
                    currentIndex += 1
                }
            }
            
            return result
        }
    }
}

actor ConcurrencyMeter {
    private var current = 0
    private(set) var peak = 0
    func enter() {
        current += 1
        peak = max(peak, current)
    }
    
    func exit() {
        current -= 1
    }
}
