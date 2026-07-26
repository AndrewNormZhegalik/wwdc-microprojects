//
//  Untitled.swift
//  SwiftUIProjects
//
//  Created by Andrey on 26.07.2026.
//
import Combine
import SwiftUI

final class Counter: ObservableObject {
    @Published var value: Int = 0
    
    init() {
        print("Counter INIT")
    }
}
