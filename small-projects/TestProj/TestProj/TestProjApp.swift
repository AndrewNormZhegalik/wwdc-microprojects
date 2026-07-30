//
//  TestProjApp.swift
//  TestProj
//
//  Created by Andrey on 30.07.2026.
//

import SwiftUI

@main
struct TestProjApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: IncrementViewModel())
        }
    }
}
