//
//  Untitled.swift
//  UIKitProject
//
//  Created by Andrey on 07.08.2026.
//
import Foundation

nonisolated enum ListItem: Hashable {
    case month(String)
    case transaction(UUID)
}
