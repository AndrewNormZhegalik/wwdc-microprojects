//
//  Untitled.swift
//  RevolutProject
//
//  Created by Andrey on 30.07.2026.
//

import XCTest
@testable import RevolutProject

@MainActor
final class TransactionsRepositoryTests: XCTestCase {
    func test_secondCall_usesCache_notHitNetwork() async throws {
        let networkService = MockNetworkService()
        networkService.result = .success([Transaction(id: "id", amount: 100)])
        
        let sut = TransactionsRepository(networkService: networkService)
        
        _ = try await sut.getTransactions()
        _ = try await sut.getTransactions()
        
        XCTAssertEqual(networkService.fetchCallCount, 1)
    }
    
    func test_networkError_propagates() async {
        let networkService = MockNetworkService()
        networkService.result = .failure(NetworkError.decodingFailed)
        
        let sut = TransactionsRepository(networkService: networkService)
        
        do {
            _ = try await sut.getTransactions()
            XCTFail("expected error to propagate")
        } catch {
            
        }
    }
}
