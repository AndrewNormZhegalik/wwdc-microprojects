//
//  TestProjTests.swift
//  TestProjTests
//
//  Created by Andrey on 30.07.2026.
//

import XCTest
@testable import TestProj

@MainActor
final class TestProjTests: XCTestCase {
    func test_ViewModel_incrementCorrectly() {
        let viewModel = IncrementViewModel()
        
        viewModel.increment()
        XCTAssertEqual(viewModel.value, 1)
    }
    
    func test_ViewModel_decrementCorrectly() {
        let viewModel = IncrementViewModel()
        
        viewModel.decrement()
        XCTAssertEqual(viewModel.value, -1)
    }
    
    func test_ViewModel_IntialValue() {
        let viewModel = IncrementViewModel()
        XCTAssertEqual(viewModel.value, 0)
    }
}
