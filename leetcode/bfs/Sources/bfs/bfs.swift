// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
// Breath first search
class Solution {
    func levelOrder(_ root: TreeNode?) -> [[Int]] { // Medium
        guard let root else { return [] }
        
        var queue = [root]
        var result: [[Int]] = []
        
        while !queue.isEmpty {
            let size = queue.count
            var level: [Int] = []
            
            for _ in 0..<size {
                let node = queue.removeFirst()
                level.append(node.val)
                
                if let left = node.left {
                    queue.append(left)
                }
                
                if let right = node.right {
                    queue.append(right)
                }
            }
            
            result.append(level)
        }
        
        return result
    }
    
    func rightSightView(_ root: TreeNode?) -> [Int] { // Medium
        guard let root else { return [] }
        var queue = [root]
        var result: [Int] = []
        
        while !queue.isEmpty {
            let size = queue.count
            
            for i in 0 ..< size {
                let node = queue.removeFirst()
                
                if i == size - 1 {
                    result.append(node.val)
                }
                
                if let left = node.left {
                    queue.append(left)
                }
                
                if let right = node.right {
                    queue.append(right)
                }
            }
        }
        
        return result
    }
    
    func minDepth(_ root: TreeNode?) -> Int { // Easy
        guard let root else { return 0 }
        var queue = [root]
        var depth = 0
        
        while !queue.isEmpty {
            let size = queue.count
            depth += 1
            
            for _ in 0..<size {
                let node = queue.removeFirst()
                
                if node.left == nil && node.right == nil {
                    return depth
                }
                
                if let left = node.left { queue.append(left) }
                if let right = node.right { queue.append(right) }
            }
        }
        
        return depth
    }
    
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root else { return [] }
        var queue = [root]
        var result: [[Int]] = []
        var depth = 0
        
        while !queue.isEmpty {
            let size = queue.count
            depth += 1
            var level = [Int]()
            
            for _ in 0..<size {
                let node = queue.removeFirst()
                
                level.append(node.val)
                
                if let left = node.left {
                    queue.append(left)
                }
                
                if let right = node.right {
                    queue.append(right)
                }
            }
            
            if depth % 2 == 0 {
                result.append(level.reversed())
            } else {
                result.append(level)
            }
        }
        
        return result
    }
}

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}
