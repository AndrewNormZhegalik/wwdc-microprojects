import XCTest
@testable import limitNumberOfConcurrentRequests

final class ImageBatchLoaderTest: XCTestCase {
    func test_AllResultsAreHandled() async throws {
        
        let imageUrls = imageUrls()
        let imageBatchLoader = ImageBatchLoader(fetch: { url in Data(url.absoluteString.utf8) })
        let result = try await imageBatchLoader.loadImages(with: imageUrls, maxConcurrent: 5)
        
        XCTAssertEqual(result.count, 10)
        
        XCTAssertEqual(Data(result[0].0.absoluteString.utf8), result[0].1)
    }
    
    func test_exactlyMaxConcurrentRequestAreExecuting() async throws {
        let imageUrls = imageUrls()
        let concurrencyMeter = ConcurrencyMeter()
        
        let imageLoader = ImageBatchLoader(fetch: { url in
            await concurrencyMeter.enter()
            try await Task.sleep(nanoseconds: 10_000_000)
            await concurrencyMeter.exit()
            return Data(url.absoluteString.utf8)
        })
        
        _ = try await imageLoader.loadImages(with: imageUrls, maxConcurrent: 4)
        
        let peak = await concurrencyMeter.peak
        
        XCTAssertLessThanOrEqual(peak, 4)
        XCTAssertGreaterThan(peak, 1)
    }
    
    
    private func imageUrls() -> [URL] {
        var imageUrls: [URL] = []
        
        for i in 1...10 {
            imageUrls.append(URL(string: "https://example.com/\(i)")!)
        }
        
        return imageUrls
    }
}
