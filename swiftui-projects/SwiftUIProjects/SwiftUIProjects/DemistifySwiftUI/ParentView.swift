//
//  Untitled.swift
//  SwiftUIProjects
//
//  Created by Andrey on 26.07.2026.
//

import SwiftUI

struct ParentView: View {
    @State private var tick = 0
    
    var body: some View {
        VStack {
            Text("tick: \(tick)")
            Button("Rebuild parent") { tick += 1 }
            
            ChildStateObject()
            ChildObserved(counter: Counter())
        }
    }
}

struct ChildStateObject: View {
    @StateObject private var counter = Counter()
    
    var body: some View {
        Text("StateObject: \(counter.value)")
    }
}

struct ChildObserved: View {
    @ObservedObject var counter: Counter
    
    var body: some View {
        Text("Observed: \(counter.value)") 
    }
}
