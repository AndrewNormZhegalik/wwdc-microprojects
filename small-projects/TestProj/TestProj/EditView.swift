//
//  Untitled.swift
//  TestProj
//
//  Created by Andrey on 30.07.2026.
//

import SwiftUI

struct EditView: View {
    @ObservedObject var viewModel: IncrementViewModel
    @Environment(\.presentationMode) private var presentationMod
    
    var body: some View {
        VStack {
            Button("Plus") {
                viewModel.increment()
                self.presentationMod.wrappedValue.dismiss()
            }
            
            Button("Minus") {
                viewModel.decrement()
            }
        }
        .padding()
    }
}
