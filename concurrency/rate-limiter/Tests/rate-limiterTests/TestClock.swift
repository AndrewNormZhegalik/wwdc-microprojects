//
//  TestClock.swift
//  rate-limiter
//
//  Created by Andrey on 12.07.2026.
//

import Foundation

final class TestClock: @unchecked Sendable {
    private let lock = NSLock()
    private var _now = Date()
    
    var now: Date {
        lock.lock()
        defer { lock.unlock() }
        return _now
    }
    
    func advance(by interval: TimeInterval) {
        lock.lock()
        defer { lock.unlock() }
        _now = _now.addingTimeInterval(interval)
    }
}
