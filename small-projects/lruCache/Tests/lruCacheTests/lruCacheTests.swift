import XCTest
@testable import lruCache

final class LRUCacheTests: XCTestCase {
    func test_lruCachePut() {
        let cache = LRUCache(capacity: 5)
        cache.put(1, 100)
        
        let first = cache.get(1)
        let second = cache.get(2)
        
        XCTAssertEqual(first, 100)
        XCTAssertNil(second)
    }
    
    func test_OverflowLRU() {
        let cache = LRUCache(capacity: 2)
        
        cache.put(0, 1)
        cache.put(1, 2)
        cache.put(2, 3)
        
        let first = cache.get(0)
        let second = cache.get(1)
        let third = cache.get(2)
        
        XCTAssertNil(first)
        XCTAssertEqual(second, 2)
        XCTAssertEqual(third, 3)
    }
    
    func test_Recency() {
        let cache = LRUCache(capacity: 2)
        
        cache.put(0, 1)
        cache.put(1, 2)
        
        _ = cache.get(0)
        
        cache.put(2, 3)
        
        let second = cache.get(1)
        
        XCTAssertNil(second)
    }
    
    func test_RecencyAndPutUpdatesExisting() {
        let cache = LRUCache(capacity: 2)
        
        cache.put(0, 1)
        cache.put(1, 2)
        
        _ = cache.get(0)
        
        cache.put(1, 3)
        cache.put(2, 4)
        
        let first = cache.get(0)
        
        XCTAssertNil(first)
    }
}
