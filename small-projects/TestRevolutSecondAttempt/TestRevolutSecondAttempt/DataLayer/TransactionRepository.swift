//
//  Untitled.swift
//  TestRevolutSecondAttempt
//
//  Created by Andrey on 29.07.2026.
//
import Foundation

protocol TransactionRepositoryProtocol {
    func loadTransactions() async throws -> [Transaction]
}

final class TransactionRepository: TransactionRepositoryProtocol {
    let networkService: NetworkServiceProtocol
    let localCache = LocalCache()
    
    init(_ networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func loadTransactions() async throws -> [Transaction] {
        if let value = await localCache.get("transactions") as? [Transaction] {
            return value
        }
        
        
        let transactions: [Transaction] = try await networkService.fetch(endpoint: TransactionEndpoint.list)
        await localCache.save("transactions", transactions)
        
        return transactions
    }
}

enum TransactionEndpoint: Endpoint {
    case list
    
    var url: URL? {
        switch self {
        case .list:
            return URL(string: "https://transactions.com/list")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .list:
            return .get
        }
    }
}
