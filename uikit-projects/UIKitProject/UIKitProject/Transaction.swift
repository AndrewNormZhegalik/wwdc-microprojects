//
//  Untitled.swift
//  UIKitProject
//
//  Created by Andrey on 06.08.2026.
//

import Foundation

nonisolated struct Transaction: Hashable {
    let id: UUID
    var title: String
    var amount: Int
}

nonisolated enum Section: Hashable {
    case main
}
