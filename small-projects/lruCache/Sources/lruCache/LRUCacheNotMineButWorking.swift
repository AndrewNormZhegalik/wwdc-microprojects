//
//  Untitled.swift
//  lruCache
//
//  Created by Andrey on 22.07.2026.
//

class LRUCacheNotMineButWorking {
    var cache: [Int: Node] = [:]
    var count: Int = 0
    let capacity: Int
    var head: Node?
    var tail: Node?
    
    
    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    
    func get(_ key: Int) -> Int {
        if let node = cache[key] {
            moveToHead(node)
            
            return node.val
        } else {
            return -1
        }
    }
    
    
    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            node.val = value
            moveToHead(node)
            
        } else {
            let node = Node(key, value)
            
            node.next = head
            head?.prev = node
            head = node
            cache[key] = node
            count += 1
            if tail == nil {
                tail = head
            }
            
            if count > capacity {
                cache.removeValue(forKey: tail!.key)
                tail = tail?.prev
                tail?.next = nil
                count -= 1
            }
        }
    }
    
    func moveToHead(_ node: Node) {
        if node === head {
            return
        } else {
            node.prev?.next = node.next
            node.next?.prev = node.prev
            node.next = head
            head?.prev = node
            head = node
        }
        if node === tail {
            tail = tail?.prev
            tail?.next = nil
        }
    }
}
