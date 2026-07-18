import XCTest
@testable import tokenRefreshCoordinator

final class TokenRefresherTests: XCTestCase {
    func test_RefreshingExecutesExactlyOnce() async throws {
        let concurrentMeter = ConcurrentMeter()
        let tokenRefresher = TokenRefresher(
            token: Token(token: "token", expirationDate: Date.now.addingTimeInterval(-10)),
            performRefresh: {
                await concurrentMeter.enter()
                try await Task.sleep(for: .milliseconds(300))
                return Token(token: "blabla", expirationDate: Date.now.addingTimeInterval(2000))
            }
        )
        
        let tokens = try await withThrowingTaskGroup(of: String.self) { group in
            for _ in 0...200 {
                group.addTask {
                    try await tokenRefresher.validToken(time: { Date.now })
                }
            }
            
            var result: [String] = []
            for try await token in group {
                result.append(token)
            }
            
            return result
        }
        
        let counter = await concurrentMeter.counter
        
        XCTAssertEqual(counter, 1)
        XCTAssertEqual(tokens[0], "blabla")
    }
    
    func test_tokenRefresherSendNewToken() async throws {
        let tokenRefresher = TokenRefresher(
            token: Token(token: "token", expirationDate: Date.now.addingTimeInterval(-10)),
            performRefresh: {
                try await Task.sleep(for: .milliseconds(300))
                return Token(token: "blabla", expirationDate: Date.now.addingTimeInterval(2000))
            }
        )
        
        let token = try await tokenRefresher.validToken(time: { Date.now })
        
        XCTAssertEqual(token, "blabla")
    }
    
    func test_tokenRefreshesOnlyOnce_thenSendRefreshedToken() async throws {
        let callCounter = ConcurrentMeter()
        let tokenRefresher = TokenRefresher(
            token: Token(token: "token", expirationDate: Date.now.addingTimeInterval(-10)),
            performRefresh: {
                await concurrentMeter.enter()
                try await Task.sleep(for: .milliseconds(300))
                return Token(token: "blabla", expirationDate: Date.now.addingTimeInterval(2000))
            }
        )
        
        let token = try await tokenRefresher.validToken(time: { Date.now })
        let tokenTwo = try await tokenRefresher.validToken(time: { Date.now })
        
        let counter = await callCounter.counter
        
        XCTAssertEqual(counter, 1)
        XCTAssertEqual(token, tokenTwo)
        XCTAssertEqual(tokenTwo, "blabla")
    }
}
