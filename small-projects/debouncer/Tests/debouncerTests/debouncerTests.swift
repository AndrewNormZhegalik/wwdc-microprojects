import XCTest
@testable import debouncer

actor Counter {
    var count: Int = 0
    
    func enter() {
        count += 1
    }
}

final class DebouncerTests: XCTestCase {
    func test_three_rapid_calls_executesOne() async throws {
        let counter = Counter()
        let sut = Debouncer(delay: 1, sleep: { _ in
            try await Task.sleep(for: .milliseconds(50))
        })
        
        await sut.schedule { await counter.enter() }
        await sut.schedule { await counter.enter() }
        await sut.schedule { await counter.enter() }
        
        try await Task.sleep(for: .milliseconds(100))
        let count = await counter.count
        XCTAssertEqual(count, 1)
    }
    
    func test_cancel_preventsExecution() async throws {
        let counter = Counter()
        let sut = Debouncer(delay: 1, sleep: { _ in
            try await Task.sleep(for: .milliseconds(50))
        })
        
        await sut.schedule {
            await counter.enter()
        }
        
        await sut.cancel()
        let count = await counter.count
        
        XCTAssertEqual(count, 0)
    }
    
    func test_twoSeparateCalls_executesTwice() async throws {
        let counter = Counter()
        let sut = Debouncer(delay: 1, sleep: { _ in
            try await Task.sleep(for: .milliseconds(50))
        })
        
        await sut.schedule {
            await counter.enter()
        }
        
        try await Task.sleep(for: .milliseconds(100))
        
        await sut.schedule {
            await counter.enter()
        }
        
        try await Task.sleep(for: .milliseconds(100))
        
        let count = await counter.count
        
        XCTAssertEqual(count, 2)
    }
}
