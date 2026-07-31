//
//  AnimationLab1.swift
//  SwiftUIProjects
//
//  Created by Andrey on 31.07.2026.
//

import SwiftUI

struct AnimationLab1: View {
    @State private var expanded = false
    
    var body: some View {
        VStack(spacing: 40) {
            // A: императивный — анимирует всё, что изменилось в блоке
            RoundedRectangle(cornerRadius: expanded ? 40 : 8)
                .fill(expanded ? .blue : .red)
                .frame(width: expanded ? 200 : 80, height: 80)
            
            // B: декларативный — анимирует только при смене value
            RoundedRectangle(cornerRadius: expanded ? 40 : 8)
                .fill(expanded ? .blue : .red)
                .frame(width: expanded ? 200 : 80, height: 80)
                .animation(.spring(duration: 0.5), value: expanded)
            
            Button("Toggle") {
                expanded.toggle()
            }
        }
    }
}
