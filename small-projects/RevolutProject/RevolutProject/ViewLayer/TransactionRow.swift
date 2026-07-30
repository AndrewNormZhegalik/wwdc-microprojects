//
//  Untitled.swift
//  RevolutProject
//
//  Created by Andrey on 27.07.2026.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            Text("id: \(transaction.id)")
                .foregroundColor(.black)
            Spacer()
            Text("\(transaction.amount)")
                .foregroundColor(.yellow)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("transaction-\(transaction.id)")
        .padding()
    }
}
