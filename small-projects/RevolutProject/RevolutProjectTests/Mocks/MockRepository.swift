//
//  Untitled.swift
//  RevolutProject
//
//  Created by Andrey on 30.07.2026.
//
@testable import RevolutProject

final class MockRepository: TransactionsRepositoryProtocol, @unchecked Sendable {
    var result: Result<[Transaction], Error> = .success([])
    
    func getTransactions() async throws -> [Transaction] {
        try result.get()
    }
}
