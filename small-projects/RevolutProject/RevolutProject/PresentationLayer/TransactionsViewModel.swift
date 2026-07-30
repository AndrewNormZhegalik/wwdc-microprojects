//
//  Untitled.swift
//  RevolutProject
//
//  Created by Andrey on 27.07.2026.
//

import Combine
import SwiftUI

@MainActor
final class TransactionsViewModel: ObservableObject {
    @Published private(set) var state: ViewState = .loading
    
    private let repository: TransactionsRepositoryProtocol
    
    init(repository: TransactionsRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadTransactions() async {
        state = .loading
        
        do {
            let items = try await repository.getTransactions()
            state = items.isEmpty ? .empty : .loaded(items)
        } catch {
            state = .error(error)
        }
    }
}

enum ViewState: Equatable {
    case loading
    case empty
    case loaded([Transaction])
    case error(Error)
    
    static func ==(lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        
        case (.empty, .empty):
            return true
            
        case let (.loaded(leftValue), .loaded(rightValue)):
            return leftValue == rightValue
            
        case let (.error(leftValue), .error(rightValue)):
            return (leftValue as NSError) == (rightValue as NSError)
            
        default:
            return false
        }
    }
}
