//
//  Untitled.swift
//  memory-image-lab
//
//  Created by Andrey on 18.07.2026.
//
import SwiftUI

struct LeakyScreen: View {
    @StateObject private var viewModel = LeakyViewModel()
    
    var body: some View {
        VStack {
            Text("Leaky Screen - close me")
                .padding(20)
        }
        .onDisappear {
            viewModel.invalidateTimer()
        }
    }
}
