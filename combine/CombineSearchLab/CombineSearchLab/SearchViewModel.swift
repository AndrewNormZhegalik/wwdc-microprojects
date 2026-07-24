//
//  Untitled.swift
//  CombineSearchLab
//
//  Created by Andrey on 24.07.2026.
//
import Combine
import Foundation

class SearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var results: [String] = []
    let url = URL(string: "https://commons.wikimedia.org/wiki/File:Big_Nature_(155420955).jpeg")!
    var cancellables: Set<AnyCancellable> = []
    
    private var continuation: AsyncStream<String>.Continuation?
    lazy var queryStream: AsyncStream<String> = AsyncStream<String> { continuation in
        self.continuation = continuation
    }
    var currentTask: Task<Void, Error>?
                        
    
    // if assign there no need to store in cancellables, without storing it won't live
    init() {
        $query
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { query in
                Just(["result for \(query)", "another for \(query)"])
                    .delay(for: .milliseconds(500), scheduler: RunLoop.main)
            }
            .receive(on: RunLoop.main)
            .assign(to: &$results)
    }
    
    // share experiment
    func download() {
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .handleEvents(receiveSubscription: { _ in print("Request fired")})
            .map(\.data)
            .replaceError(with: Data())
            .share()
        
        publisher.sink { print("sink A got ", $0.count) }.store(in: &cancellables)
        publisher.sink { print("sink B got ", $0.count) }.store(in: &cancellables)
        
        [1, 2, 3, 4, 5].publisher.subscribe(TwoOnly())
    }
    
    // asyncStream approach
    func queryChanged(_ text: String) {
        continuation?.yield(text)
        
        currentTask?.cancel()
        currentTask = Task {
            for await query in queryStream {
                try? await Task.sleep(for: .milliseconds(300))
                guard !Task.isCancelled else { return }
                results  = await fakeSearch(query)
            }
        }
    }
    
    func fakeSearch(_ query: String) async -> [String] {
        return ["blabla"]
    }
}

// Demand experiment
final class TwoOnly: Subscriber {
    typealias Input = Int
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.max(2)) // <- Demand 2 !!!!!
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        print(input)
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("done")
    }
}
