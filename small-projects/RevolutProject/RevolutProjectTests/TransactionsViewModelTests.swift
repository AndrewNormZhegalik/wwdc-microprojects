//
//  RevolutProjectTests.swift
//  RevolutProjectTests
//
//  Created by Andrey on 27.07.2026.
//

import XCTest
@testable import RevolutProject

final class TransactionsViewModelTests: XCTestCase {
    
    @MainActor
    func test_load_success_setsLoaded() async {
        let repo = MockRepository()
        repo.result = .success([Transaction(id: "1", amount: 100)])
        
        let sut = TransactionsViewModel(repository: repo)
        await sut.loadTransactions()
        
        guard case let .loaded(items) = sut.state else {
            return XCTFail("expected loaded, got \(sut.state)")
        }
        
        XCTAssertEqual(items.count, 1)
    }
    
    @MainActor
    func test_load_empty_setsEmpty() async {
        let repo = MockRepository()
        repo.result = .success([])
        let sut = TransactionsViewModel(repository: repo)
        await sut.loadTransactions()
        
        XCTAssertEqual(sut.state, .empty)
    }
    
    @MainActor
    func test_load_failure_setsError() async {
        let repo = MockRepository()
        repo.result = .failure(NetworkError.badURL)
        let sut = TransactionsViewModel(repository: repo)
        await sut.loadTransactions()
        
        guard case let .error(error) = sut.state else {
            return XCTFail("expected failure, got \(sut.state)")
        }
        
        XCTAssertNotNil(error)
    }
}
