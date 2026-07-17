// The Swift Programming Language
// https://docs.swift.org/swift-book


final class TickerStream {
    static func makeStream(with ticker: Ticker) -> AsyncStream<Int> {
        return AsyncStream { continuation in
            let task = Task {
                await ticker.start { value in
                    continuation.yield(value)
                }
            }
            
            continuation.onTermination = { _ in
                task.cancel()
                
                Task {
                    await ticker.stop()
                }
            }
        }
    }
}
