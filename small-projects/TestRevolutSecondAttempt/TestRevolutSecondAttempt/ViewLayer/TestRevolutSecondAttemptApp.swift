//
//  TestRevolutSecondAttemptApp.swift
//  TestRevolutSecondAttempt
//
//  Created by Andrey on 29.07.2026.
//

import SwiftUI

@main
struct TestRevolutSecondAttemptApp: App {
    var body: some Scene {
        WindowGroup {
            TransactionsListView(viewModel: TransactionsListViewModel(TransactionRepository(NetworkService())))
        }
    }
}
