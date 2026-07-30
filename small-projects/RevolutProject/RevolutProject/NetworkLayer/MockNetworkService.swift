//
//  Untitled.swift
//  RevolutProject
//
//  Created by Andrey on 30.07.2026.
//
import Foundation

final class MockNetworkService: NetworkServiceProtocol, @unchecked Sendable {
    private(set) var fetchCallCount: Int = 0
    var result: Result<[Transaction], Error> = .success([])
    
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        fetchCallCount += 1
        
        switch result {
        case let .success(transactions):
            return transactions as! T
            
        case let .failure(error):
            throw error
        }
    }
}
