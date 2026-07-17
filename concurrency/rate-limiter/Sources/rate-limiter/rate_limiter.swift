// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

actor RateLimiter {
    private let maxRequests: Int
    private let window: TimeInterval
    private let now: () -> Date
    private var timeStamps: [Date] = []
    
    init(
        maxRequests: Int,
        window: TimeInterval,
        now: @escaping () -> Date = { Date() }
    ) {
        self.maxRequests = maxRequests
        self.window = window
        self.now = now
    }
    
    func allowRequest() -> Bool {
        let cutoff = now().addingTimeInterval(-window)
        timeStamps.removeAll(where: { $0 < cutoff })
        
        guard timeStamps.count < maxRequests else { return false }
        timeStamps.append(now())
        return true
    }
}
