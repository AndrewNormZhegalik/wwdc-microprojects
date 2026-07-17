import XCTest
@testable import AsyncStream

final class AsynStreamTests: XCTestCase {
    func test_asyncStreamYieldElements() async {
        let stream = TickerStream.makeStream(with: Ticker())
        
        var values: [Int] = []
        
        for await value in stream.prefix(5) {
            values.append(value)
        }
        
        XCTAssertEqual(values.count, 5)
    }
    
    func test_TickerIsntRunningAfterStop() async {
        let ticker = Ticker()
        let stream = TickerStream.makeStream(with: ticker)
        
        var task = Task {
            var values: [Int] = []
            for await value in stream.prefix(4)
        }
    }
}
