//
//  RevolutProjectUITests.swift
//  RevolutProjectUITests
//
//  Created by Andrey on 27.07.2026.
//

import XCTest

final class RevolutProjectUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func test_transactionsList_showsRows() {
        let app = XCUIApplication()
        app.launchArguments = ["-UITestMockData"]
        app.launch()
        print("description: \(app.debugDescription)")
        
        XCTAssertTrue(app.navigationBars["Transactions"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["transaction-1"].waitForExistence(timeout: 3))
    }
    
    @MainActor
    func test_emptyState_showsMessage() {
        let app = XCUIApplication()
        app.launchArguments = ["-UITestEmptyData"]
        app.launch()
        
        XCTAssertTrue(app.staticTexts["emptyTextIndicator"].waitForExistence(timeout: 3))
    }
    
    @MainActor
    func test_errorState_retryButtonExists() {
        let app = XCUIApplication()
        app.launchArguments = ["-UITestErrorData"]
        app.launch()
        
        XCTAssertTrue(app.buttons["retry-button"].waitForExistence(timeout: 3))
        //app.buttons["retry-button"].tap()
    }
}
