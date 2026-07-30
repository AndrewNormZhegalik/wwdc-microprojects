//
//  ContentView.swift
//  TestProj
//
//  Created by Andrey on 30.07.2026.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case edit
    case settings
    
    var id: String {
        switch self {
        case .edit: "edit"
        case .settings: "settings"
        }
    }
}

struct ContentView: View {
    @StateObject var viewModel: IncrementViewModel
    @State var activeSheet: ActiveSheet?
    
    var body: some View {
        VStack {
            Text("\(viewModel.value)")
            Button("Edit") {
                activeSheet = .edit
            }
            Button("getValue") {
                viewModel.getValue()
            }
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .edit: EditView(viewModel: viewModel)
            case .settings: EditView(viewModel: viewModel)
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView(viewModel: IncrementViewModel())
}
