//
//  ContentView.swift
//  CombineSearchLab
//
//  Created by Andrey on 24.07.2026.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        VStack {
            TextField("Query...", text: $viewModel.query)
                .foregroundColor(.black)
            List(viewModel.results, id: \.self) { result in
                Text(result)
            }
        }
        .onAppear {
            viewModel.download()
        }
    }
}

#Preview {
    ContentView(viewModel: SearchViewModel())
}
