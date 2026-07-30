//
//  Untitled.swift
//  RevolutProject
//
//  Created by Andrey on 30.07.2026.
//

import Testing
@testable import RevolutProject

@Suite("Transaction ViewModel")
@MainActor
struct TransactionsViewModelSwiftTests {
    @Test("loaded on success")
    func loadedOnSuccess() async {
        let repo = MockRepository()
        repo.result = .success([Transaction(id: "1", amount: 100)])
        let sut = TransactionsViewModel(repository: repo)
        
        await sut.loadTransactions()
        
        #expect(sut.state == .loaded([Transaction(id: "1", amount: 100)]))
    }
    
    func loadedOnEmpty() async {
        let repo = MockRepository()
        repo.result = .success([])
        let sut = TransactionsViewModel(repository: repo)
        
        await sut.loadTransactions()
        
        #expect(sut.state == .empty)
    }
    
    @Test(arguments: [1, 2, 10])
    func loadsNTransactions(_ count: Int) async {
        let transactions = (0..<count).map {
            Transaction(id: "transaction-\($0)", amount: ($0 + 1) * 100)
        }
        let repo = MockRepository()
        repo.result = .success(transactions)
        let sut = TransactionsViewModel(repository: repo)
        await sut.loadTransactions()
        
        guard case let .loaded(items) = sut.state else {
            Issue.record("expected .loaded, got \(sut.state)")
            return
        }
        
        #expect(items.count == count)
    }
}
