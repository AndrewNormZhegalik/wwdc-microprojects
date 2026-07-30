//
//  Untitled.swift
//  TestRevolutSecondAttempt
//
//  Created by Andrey on 29.07.2026.
//

import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            Text("\(transaction.id)")
                .foregroundColor(.yellow)
            Spacer()
            Text("\(transaction.amount)")
                .foregroundColor(.red)
        }
        .padding()
    }
}
