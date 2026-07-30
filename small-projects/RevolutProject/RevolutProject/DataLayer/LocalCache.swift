//
//  Untitled.swift
//  RevolutProject
//
//  Created by Andrey on 27.07.2026.
//

actor LocalCache {
    final class Node {
        let key: String
        var value: Any
        var next: Node?
        var previous: Node?
        
        init(
            key: String = "",
            value: Any = "",
            next: Node? = nil,
            previous: Node? = nil
        ) {
            self.key = key
            self.value = value
            self.next = next
            self.previous = previous
        }
    }
    
    let capacity: Int
    private var cache: [String: Node] = [:]
    var head = Node()
    var tail = Node()
    
    init(capacity: Int) {
        self.capacity = capacity
        head.next = tail
    }
    
    func get(_ key: String) -> Any? {
        guard let node = cache[key] else { return nil }
        
        moveToHead(node)
        return node.value
    }
    
    func put(_ value: Any, for key: String) {
        if let node = cache[key] {
            node.value = value
            moveToHead(node)
        } else {
            let node = Node(key: key, value: value)
            cache[key] = node
            moveToHead(node)
            
            if cache.count > capacity {
                removeFromTail()
            }
        }
    }
    
    func moveToHead(_ node: Node) {
        guard node.previous !== head else { return }
        
        let currentNode = node
        let previous = node.previous
        let next = node.next
        previous?.next = next
        next?.previous = previous
        
        let headNext = head.next
        currentNode.previous = head
        currentNode.next = headNext
        headNext?.previous = currentNode
        head.next = currentNode
    }
    
    func removeFromTail() {
        guard let key = tail.previous?.key else { return }
        let previous = tail.previous
        previous?.previous?.next = tail
        tail.previous = previous?.previous
        previous?.next = nil
        previous?.previous = nil
        cache[key] = nil
    }
}
