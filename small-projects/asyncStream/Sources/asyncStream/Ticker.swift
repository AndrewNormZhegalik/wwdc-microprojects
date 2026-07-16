//
//  Ticker.swift
//  AsyncStream
//
//  Created by Andrey on 16.07.2026.
//

actor Ticker {
    var counter: Int = 0
    var task: Task<Void, Error>?
    var isRunning: Bool {
        task?.isCancelled == false
    }
    
    func start(onTick: @escaping (Int) -> Void) {
        task = Task {
            while !Task.isCancelled {
                counter += 1
                onTick(counter)
                try await Task.sleep(for: .seconds(1))
            }
        }
    }
    
    func stop() {
        task?.cancel()
    }
}
