// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

actor RateLimiter {
    let maxRequests: Int
    let window: TimeInterval
    let now: () -> Date
    var timeStamps: [Date] = []
    
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
        let timeRange = now().addingTimeInterval(-window)
        timeStamps.removeAll(where: { $0 < timeRange })
        guard timeStamps.count < maxRequests else { return false }
        timeStamps.append(now())
        return true
    }
}
