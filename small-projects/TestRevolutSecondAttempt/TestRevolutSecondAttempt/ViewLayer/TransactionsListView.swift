//
//  ContentView.swift
//  TestRevolutSecondAttempt
//
//  Created by Andrey on 29.07.2026.
//

import SwiftUI

struct TransactionsListView: View {
    @StateObject var viewModel: TransactionsListViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .empty:
                    Text("No transactions found...")
                    
                case let .success(transactions):
                    List {
                        ForEach(transactions) { transaction in
                            TransactionRowView(transaction: transaction)
                        }
                    }
                    
                case .loading:
                    ProgressView("Loading transactions...")
                    
                case let .failure(message):
                    VStack {
                        Text("Failure: \(message)")
                        Button("Retry") {
                            viewModel.loadTransactions()
                        }
                    }
                    .padding()
                }
            }
            .task {
                viewModel.loadTransactions()
            }
        }
    }
}

#Preview {
    TransactionsListView(viewModel: TransactionsListViewModel(TransactionRepository(NetworkService())))
}
