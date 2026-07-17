//
//  Untitled.swift
//  rate-limiter
//
//  Created by Andrey on 13.07.2026.
//

import XCTest
@testable import rate_limiter

final class RateLimiterTests: XCTestCase {
    func test_whenAdvancingTime() async {
        let clock = TestClock()
        let limiter = RateLimiter(maxRequests: 2, window: 5, now: { clock.now })
        
        _ = await limiter.allowRequest()
        _ = await limiter.allowRequest()
        let third = await limiter.allowRequest()
        XCTAssertFalse(third)
        
        clock.advance(by: 6)
        
        let fourth = await limiter.allowRequest()
        XCTAssertTrue(fourth)
    }
    
    func test_whenLotsOfTask() async {
        let limiter = RateLimiter(maxRequests: 10, window: 10)
        
        let allowed = await withTaskGroup(of: Bool.self) { group in
            for _ in 1...100 {
                group.addTask {
                    await limiter.allowRequest()
                }
            }
            
            return await group.reduce(0) { $0 + ($1 ? 1 : 0)}
        }
        
        XCTAssertEqual(allowed, 10)
    }
}
