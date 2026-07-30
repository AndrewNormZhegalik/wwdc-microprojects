//
//  Untitled.swift
//  RevolutProject
//
//  Created by Andrey on 27.07.2026.
//

import SwiftUI

struct TransactionsListView: View {
    @StateObject var viewModel: TransactionsViewModel
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView("Loading transactions....")
                        .accessibilityIdentifier("loading-indicator")
                    
                case .empty:
                    Text("No transactions found")
                        .accessibilityIdentifier("emptyTextIndicator")
                    
                case let .loaded(transactions):
                    List(transactions) { transaction in
                        TransactionRow(transaction: transaction)
                    }
                    .accessibilityIdentifier("transaction-list")
                    
                case let .error(message):
                    VStack {
                        Text("Error: \(message)")
                            .foregroundColor(.red)
                        Button("Retry") {
                            Task {
                                await viewModel.loadTransactions()
                            }
                        }
                        .accessibilityIdentifier("retry-button")
                    }
                }
            }
            .navigationTitle("Transactions")
            .task {
                await viewModel.loadTransactions()
            }
        }
    }
}
