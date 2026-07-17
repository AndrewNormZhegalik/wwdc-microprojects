// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import UIKit

actor ImageCache {
    private var tasks: [URL: Task<UIImage, Error>] = [:]
    
    func image(for url: URL) async throws -> UIImage {
        if let task = cache[url] {
            return try await task.value
        }
        
        let newTask = Task {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                throw ImageDownloadError.cannotDecodeImage
            }
            return image
        }
        
        tasks[url] = newTask
        
        do {
            return try await newTask.value
        } catch {
            tasks[url] = nil
            throw
        }
    }
    Thread.current
}

enum ImageDownloadError: Error {
    case cannotDecodeImage
}
