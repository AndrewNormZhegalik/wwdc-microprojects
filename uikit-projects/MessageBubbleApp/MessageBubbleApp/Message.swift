//
//  Untitled.swift
//  MessageBubbleApp
//
//  Created by Andrey on 09.08.2026.
//

import Foundation

struct Message {
    let id = UUID()
    let text: String
    let isOutgoing: Bool
}

enum MessageFactory {
    private static let  lorem = "Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore"
    
    static func make(count: Int) -> [Message] {
        let words = lorem.split(separator: " ")
        return (0...count).map { i in
            let chunk = words.shuffled().prefix(Int.random(in: 1...20))
            return Message(text: chunk.joined(separator: " "), isOutgoing: i % 3 == 0)
        }
    }
}
