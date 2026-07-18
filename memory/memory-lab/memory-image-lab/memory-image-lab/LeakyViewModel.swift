//
//  LeakyViewModel.swift
//  memory-image-lab
//
//  Created by Andrey on 18.07.2026.
//
import Foundation
import Combine

final class LeakyViewModel: ObservableObject, LeakyDelegate {
    let provider: DataProvider = DataProvider()
    var timer: Timer?
    
    init() {
        provider.callback = { [weak self] in
            self?.refresh()
        }
        provider.delegate = self
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }
    
    func refresh() {
        print(#function)
    }
    
    func tick() {
        print("tick")
    }
    
    func didUpdate() {
        print("didUpdate")
    }
    
    func invalidateTimer() {
        print("timer invalidated")
        timer?.invalidate()
    }
    
    deinit {
        print("Leaky viewModel is deinited")
    }
}

protocol LeakyDelegate: AnyObject {
    func didUpdate()
}
