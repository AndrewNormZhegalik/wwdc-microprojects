// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

actor TokenRefresher {
    private var token: Token
    private var refreshing: Task<Token, Error>?
    private let performRefresh: () async throws -> Token
    
    init(
        token: Token,
        performRefresh: @escaping @Sendable () async throws -> Token
    ) {
        self.token = token
        self.performRefresh = performRefresh
    }
    
    func validToken(time: @escaping () -> Date) async throws -> String {
        if token.expirationDate > time() {
            return token.token
        }
        
        if let refreshing = refreshing {
            return try await refreshing.value.token
        }
        
        refreshing = Task {
            try await performRefresh()
        }
        
        do {
            guard let token = try await refreshing?.value else { throw RefreshError.refreshingError }
            self.token = token
            refreshing = nil
            return token.token
        } catch {
            refreshing = nil
            throw error
        }
    }
}

struct Token {
    let token: String
    let expirationDate: Date
}

enum RefreshError: Error {
    case refreshingError
}

actor ConcurrentMeter {
    var counter = 0
    
    func enter() {
        counter += 1
    }
}
