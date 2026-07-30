//
//  Untitled.swift
//  RevolutProject
//
//  Created by Andrey on 27.07.2026.
//

struct Transaction: Decodable, Identifiable, Equatable {
    let id: String
    let amount: Int
}
