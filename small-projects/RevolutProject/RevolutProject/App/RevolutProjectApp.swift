//
//  RevolutProjectApp.swift
//  RevolutProject
//
//  Created by Andrey on 27.07.2026.
//

import SwiftUI

@main
struct RevolutProjectApp: App {
    var body: some Scene {
        WindowGroup {
            TransactionsListView(viewModel: TransactionsViewModel(repository: Self.makeRepository()))
        }
    }
    
    static func makeRepository() -> TransactionsRepositoryProtocol {
        if ProcessInfo.processInfo.arguments.contains("-UITestMockData") {
            let networkService = MockNetworkService()
            networkService.result = .success([
                Transaction(id: "1", amount: 100),
                Transaction(id: "2", amount: 200)
            ])
            return TransactionsRepository(networkService: networkService)
            
        } else if ProcessInfo.processInfo.arguments.contains("-UITestEmptyData") {
            let networkService = MockNetworkService()
            networkService.result = .success([])
            return TransactionsRepository(networkService: networkService)
        } else if ProcessInfo.processInfo.arguments.contains("-UITestErrorData") {
            let networkService = MockNetworkService()
            networkService.result = .failure(NetworkError.decodingFailed)
            return TransactionsRepository(networkService: networkService)
        }
        
        return TransactionsRepository(networkService: NetworkService())
    }
}
