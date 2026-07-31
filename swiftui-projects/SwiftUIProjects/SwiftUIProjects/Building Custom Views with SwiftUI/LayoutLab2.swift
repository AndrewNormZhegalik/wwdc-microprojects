//
//  Untitled.swift
//  SwiftUIProjects
//
//  Created by Andrey on 29.07.2026.
//

import SwiftUI

struct LayoutLab2: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("This is a very long text that wants space")
                    .border(.red)
                Text("Short but higher")
                    .border(.blue)
            }
            
            HStack {
                Text("This is a very long text that wants space")
                    .border(.red)
                
                Text("Short but higher")
                    .layoutPriority(1)      // ← отдай ей место первой
                    .border(.blue)
            }
        }
        .frame(width: 200)
        .lineLimit(1)
    }
}
