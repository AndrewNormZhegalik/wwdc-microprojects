// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@main
struct checked_continuation {
    let urlSession = URLSession(configuration: .default, delegate: self, delegatteQueue: concurrentQueue)
    static func main() async throws {
        let data = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<String, Error>) in
            fetchData { result in
                switch result {
                case let .success(data):
                    continuation.resume(returning: data)
                    
                case let .failure(_):
                    return
                }
            }
        }
        print(data)
    }
    
    static func fetchData(completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion(.success("Hello"))
        }
    }
}
