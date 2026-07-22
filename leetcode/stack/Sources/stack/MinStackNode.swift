//
//  Untitled.swift
//  stack
//
//  Created by Andrey on 22.07.2026.
//

class MinStackLinkedList { // MinStack medium
    var head: Node<Int>!

    init() {
        head = nil
    }
    
    func push(_ value: Int) {
        if head == nil {
            head = Node(value: value, min: value)
        } else {
            head = Node(value: value, min: min(value, head.min), next: head)
        }
    }
    
    func pop() {
        head = head.next
    }
    
    func top() -> Int {
        head.value
    }
    
    func getMin() -> Int {
        head.min
    }
}

class Node<T> {
    var value: T
    var min: T
    var next: Node?

    init(value: T, min: T, next: Node? = nil) {
        self.value = value
        self.next = next
        self.min = min
    }
}
