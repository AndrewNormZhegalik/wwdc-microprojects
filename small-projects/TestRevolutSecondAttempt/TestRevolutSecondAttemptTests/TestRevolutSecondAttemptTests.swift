//
//  TestRevolutSecondAttemptTests.swift
//  TestRevolutSecondAttemptTests
//
//  Created by Andrey on 29.07.2026.
//

import XCTest
@testable import TestRevolutSecondAttempt

final class MockNetworkService: @unchecked Sendable, NetworkServiceProtocol {
    var result: Result<Any, Error>?
    let counter = Counter()
    
    init() {}
    
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        await counter.enter()
        
        switch result {
        case let .success(data):
            return data as! T
            
        case let .failure(error):
            throw error
        
        case .none:
            fatalError("Result should exist")
        }
    }
}

actor Counter {
    var amount: Int = 0
    
    func enter() {
        amount += 1
    }
}

final class TestRevolutSecondAttemptTests: XCTestCase {
    func testRepository_getTransactions() async throws {
        let mockNetwork = MockNetworkService()
        let expectedTransaction = [Transaction(id: "id", amount: 100)]
        mockNetwork.result = .success(expectedTransaction)
        
        let sut = await TransactionRepository(mockNetwork)
        let actualTransaction = try await sut.loadTransactions()
        let secondResult = try await sut.loadTransactions()
        let count = await mockNetwork.counter.amount
        let id = await actualTransaction.first?.id
        
        XCTAssertEqual(id, "id")
        XCTAssertEqual(count, 1)
    }
}
