// The Swift Programming Language
// https://docs.swift.org/swift-book

import CoreLocation

class AsyncStream {
    func perform() {
        let locations = AsyncLocationStream()
        
        let task = Task {
            for await location in locations.stream {
                print(location)
            }
        }
        
        task.cancel()
    }
}

class AsyncLocationStream: NSObject, CLLocationManagerDelegate {
    lazy var stream: AsyncStream<CLLocation> = {
        AsyncStream(bufferingPolicy: .bufferingNewest(1)) { (continuation: AsyncStream<CLLocation>.Continuation) -> Void in
            self.continuation = continuation
            
            self.continuation?.onTermination = { result in
                print(result)
                self.continuation = nil
            }
        }
    }
    var continuation: AsyncStream<CLLocation>.Continuation?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            continuation.yield(location)
        }
    }
}
