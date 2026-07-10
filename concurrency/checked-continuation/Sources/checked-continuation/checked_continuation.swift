// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@main
struct checked_continuation {
    static func main() async throws {
        let number = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Int, Error>) in
            fetchNumber { result in
                switch result {
                case let .success(number):
                    continuation.resume(returning: number)
                    
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
        print(number)
    }
    
    static func fetchNumber(completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion(.success(42))
        }
    }
}
