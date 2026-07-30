//
//  Untitled.swift
//  TestRevolutSecondAttempt
//
//  Created by Andrey on 29.07.2026.
//
import Combine
import Foundation

@MainActor
final class TransactionsListViewModel: ObservableObject {
    @Published private(set) var state: ViewState = .loading

    let repository: TransactionRepositoryProtocol
    
    init(_ repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadTransactions() {
        state = .loading
        
        Task {
            do {
                let transactions = try await repository.loadTransactions()
                state = transactions.isEmpty ? .empty : .success(transactions)
            } catch {
                state = .failure(error.localizedDescription)
            }
        }
    }
}

enum ViewState {
    case loading
    case empty
    case success([Transaction])
    case failure(String)
}


