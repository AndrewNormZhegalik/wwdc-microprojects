//
//  Untitled.swift
//  SwiftUIProjects
//
//  Created by Andrey on 31.07.2026.
//

import SwiftUI

struct ItemNew: Identifiable {
    let id = UUID()        // стабильная identity
    var title: String      // меняемое содержимое
}

struct AnimationLab2: View {
    @State private var items = [ItemNew(title: "A"), ItemNew(title: "B")]
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Add") {
                withAnimation {
                    items[0].title = "D"
                }
            }
            
            ForEach(items) { item in
                Text(item.title)
                    .padding()
                    .background(.blue.opacity(0.2))
                    .animation(.easeInOut, value: item.title)
                    .transition(.move(edge: .bottom))          // ← ДЫРКА: попробуй .scale, .opacity, .move(edge:)
                    .onTapGesture {
                        withAnimation { items.removeAll { $0.id == item.id } }
                    }
            }
        }
    }
}
