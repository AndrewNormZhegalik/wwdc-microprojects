//
//  Untitled.swift
//  RevolutProject
//
//  Created by Andrey on 30.07.2026.
//

import XCTest
@testable import RevolutProject

@MainActor
final class TransactionsIntegrationTests: XCTestCase {
    func test_viewModel_withRealRepository_loadsAndCache() async {
        let networkService = MockNetworkService()
        networkService.result = .success([Transaction(id: "id", amount: 100)])
        
        let repo = TransactionsRepository(networkService: networkService)
        let sut = TransactionsViewModel(repository: repo)
        
        await sut.loadTransactions()
        await sut.loadTransactions()
        
        guard case let .loaded(item) = sut.state else {
            return XCTFail("expected loaded, got \(sut.state)")
        }
        
        XCTAssertEqual(networkService.fetchCallCount, 1)
        XCTAssertEqual(item, [Transaction(id: "id", amount: 100)])
    }
}
