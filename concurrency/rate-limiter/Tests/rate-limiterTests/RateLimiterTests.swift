//
//  Untitled.swift
//  rate-limiter
//
//  Created by Andrey on 12.07.2026.
//

import XCTest
@testable import rate_limiter

final class RateLimiterTests: XCTestCase {
    func test_rateLimiterAllowAfterRange() async {
        let clock = TestClock()
        let limiter = RateLimiter(maxRequests: 2, window: 5, now: { clock.now })
        
        _ = await limiter.allowRequest()
        _ = await limiter.allowRequest()
        let third = await limiter.allowRequest()
        XCTAssertFalse(third)
        
        clock.advance(by: 7)
        
        _ = await limiter.allowRequest()
        let fifth = await limiter.allowRequest()
        XCTAssertTrue(fifth)
    }
    
    func test_concurrentRequestsRespectLimit() async {
        let limiter = RateLimiter(maxRequests: 5, window: 10)
        let allowed = await withTaskGroup(of: Bool.self) { group in
            for _ in 1...100 {
                group.addTask { await limiter.allowRequest() }
            }
            
            return await group.reduce(0) { $0 + ($1 ? 1 : 0) }
        }
        
        XCTAssertEqual(allowed, 5)
    }
}

