//
//  CombineSearchLabApp.swift
//  CombineSearchLab
//
//  Created by Andrey on 24.07.2026.
//

import SwiftUI

@main
struct CombineSearchLabApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: SearchViewModel())
        }
    }
}
