// The Swift Programming Language
// https://docs.swift.org/swift-book

class Solution {
    func invertBinaryTree(_ root: TreeNode?) -> TreeNode? {
        guard let root else { return nil }
        
        let temp = root.left
        root.left = root.right
        root.right = temp
        
        invertBinaryTree(root.left)
        invertBinaryTree(root.right)
        
        return root
    }
    
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root else { return 0 }
        
        let depth = 1 + max(maxDepth(root.left), maxDepth(root.right))
        
        return depth
    }
}

class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ value: Int) {
        self.value = value
    }
}
