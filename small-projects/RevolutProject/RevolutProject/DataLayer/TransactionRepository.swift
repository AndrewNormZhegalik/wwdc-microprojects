//
//  Untitled.swift
//  RevolutProject
//
//  Created by Andrey on 27.07.2026.
//
import Foundation

protocol TransactionsRepositoryProtocol: Sendable {
    func getTransactions() async throws -> [Transaction]
}

final class TransactionsRepository: TransactionsRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let cache = LocalCache(capacity: 10)
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getTransactions() async throws -> [Transaction] {
        if let cached = await cache.get("transactions") as? [Transaction] {
            return cached
        }
        
        let endpoint = TransactionsEndpoint.list
        let transactions: [Transaction] = try await networkService.fetch(endpoint: endpoint)
        
        await cache.put(transactions, for: "transactions")
        return transactions
    }
}

enum TransactionsEndpoint: Endpoint {
    case list
    
    
    var url: URL? {
        switch self {
        case .list:
            URL(string: "https://example.com")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .list: .get
        }
    }
}
