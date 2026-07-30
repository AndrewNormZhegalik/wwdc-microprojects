// The Swift Programming Language
// https://docs.swift.org/swift-book

class LRUCache {
    var storage: [Int: Node]
    var capacity: Int
    var head: Node
    var tail: Node

    init(_ capacity: Int) {
        storage = [:]
        self.capacity = capacity
        head = Node()
        tail = Node()
        head.next = tail
    }

    
    func get(_ key: Int) -> Int {
        guard let node = storage[key] else { return -1 }
        
        moveToHead(node)
        return node.value
    }

    
    func put(_ key: Int, _ value: Int) {
        if let node = storage[key] {
            node.value = value
            moveToHead(node)
        } else {
            let node = Node(key: key, value: value)
            moveToHead(node)
            storage[key] = node
            
            if storage.keys.count > capacity {
                removeFromTail()
            }
        }
    }

    private func moveToHead(_ node: Node) {
        if node.previous === head {
            return
        }
        
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

    private func removeFromTail() {
        guard let key = tail.previous?.key else { return }
        let previous = tail.previous
        tail.previous = previous?.previous
        previous?.previous?.next = tail
        previous?.next = nil
        previous?.previous = nil
        storage[key] = nil
    }
}

class Node {
    var key: Int
    var value: Int
    var next: Node?
    var previous: Node?
    
    init(
        key: Int = 0,
        value: Int = 0,
        next: Node? = nil,
        previous: Node? = nil
    ) {
        self.key = key
        self.value = value
        self.next = next
        self.previous = previous
    }
}

class MinStack {
    var head: Node!
    
    init() {
        head = nil
    }
    
    func push(_ value: Int) {
        if head == nil {
            head = Node(value: value, minValue: value, next: head)
        } else {
            head = Node(value: value, minValue: min(value, head.minValue), next: head)
        }
    }
    
    func pop() {
        head = head.next
    }
    
    func top() -> Int {
        head.value
    }
    
    func getMin() -> Int {
        head.minValue
    }
}

class Node {
    var value: Int
    var minValue: Int
    var next: Node?
    
    init(value: Int, minValue: Int, next: Node? = nil) {
        self.value = value
        self.minValue = minValue
        self.next = next
    }
}


