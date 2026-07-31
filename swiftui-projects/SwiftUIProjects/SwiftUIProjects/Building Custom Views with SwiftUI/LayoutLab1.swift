//
//  Untitled.swift
//  SwiftUIProjects
//
//  Created by Andrey on 29.07.2026.
//

import SwiftUI

struct LayoutLab1: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "star.fill")
                .frame(width: 100, height: 100)
                .border(.red)
            
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .border(.blue)
        }
    }
}
