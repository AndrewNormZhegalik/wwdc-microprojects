// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

actor ImageCache {
    var cache: [URL: Task<UIImage?, Error>] = [:]
    
    func image(for url: URL) async throws -> UIImage? {
        if let existingTask = cache[url] {
            return try await existingTask.value
        }
        
        let newTask = Task {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        }
        
        cache[url] = newTask
        
        do {
            return try await newTask.value
        } catch {
            cache[url] = nil
            return nil
        }
    }
}
