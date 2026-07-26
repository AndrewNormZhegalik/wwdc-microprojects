//
//  Untitled.swift
//  SwiftUIProjects
//
//  Created by Andrey on 26.07.2026.
//
import SwiftUI

struct Item: Identifiable {
    let name: String
    let id = UUID()
}

struct ListExperiment: View {
    @State private var items = [Item(name: "A"), Item(name: "B"), Item(name: "C"), Item(name: "D")]
    
    var body: some View {
        VStack {
            Button("prepend") {
                withAnimation {
                    items.insert(Item(name: "new"), at: 0)
                }
            }
            ForEach(items) { item in
                Text(item.name)
                    .padding()
                    .background(.blue.opacity(0.2))
            }
        }
    }
}
