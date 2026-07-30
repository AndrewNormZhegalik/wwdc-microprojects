//
//  Untitled.swift
//  RevolutProject
//
//  Created by Andrey on 30.07.2026.
//

import XCTest
@testable import RevolutProject

final class LocalCacheTests: XCTestCase {
    func test_evictsLeastRecentlyUsed() async {
        let sut = LocalCache(capacity: 2)
        await sut.put(1, for: "1")
        await sut.put(2, for: "2")
        
        _ = await sut.get("1")
        await sut.put(3, for: "3")
        
        let two = await sut.get("2")
        let one = await sut.get("1")
        let three = await sut.get("3")
        
        XCTAssertNil(two)
        XCTAssertNotNil(one)
        XCTAssertNotNil(three)
    }
    
    func test_updateExistingKey_doesNotGrowCache() async {
        let sut = LocalCache(capacity: 2)
        
        await sut.put(1, for: "1")
        await sut.put(2, for: "2")
        await sut.put(3, for: "2")
        
        let two: Int? = await sut.get("2") as? Int
        let one: Int? = await sut.get("1") as? Int
        
        XCTAssertEqual(two, 3)
        XCTAssertEqual(one, 1)
    }
}
