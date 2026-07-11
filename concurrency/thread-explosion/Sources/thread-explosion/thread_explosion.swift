// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@main
struct ThreadExplosion {
    static func main() async throws {
        let start = Date()
        try await withThrowingTaskGroup(of: Void.self) { group in
            for _ in 1...200 {
                group.addTask {
                    usleep(5_000_000)
                }
            }
            
            try await group.waitForAll()
        }
        
        print("Elapsed:", Date().timeIntervalSince(start))
    }
}
