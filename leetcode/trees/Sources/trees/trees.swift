// The Swift Programming Language
// https://docs.swift.org/swift-book

class Solution {
    func invertBinaryTree(_ root: TreeNode?) -> TreeNode? { // Easy
        guard let root else { return nil }
        
        let temp = root.left
        root.left = root.right
        root.right = temp
        
        invertBinaryTree(root.left)
        invertBinaryTree(root.right)
        
        return root
    }
    
    func maxDepth(_ root: TreeNode?) -> Int { // Easy
        guard let root else { return 0 }
        
        let depth = 1 + max(maxDepth(root.left), maxDepth(root.right))
        
        return depth
    }
    
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool { // Easy
        guard let p, let q else {
            return p == nil && q == nil
        }
        
        return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
    }
    
    func mergeTrees(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? {
        if root1 == nil && root2 == nil {
            return nil
        }
        
        let val1: Int
        let val2: Int
        
        if let root1 {
            val1 = root1.val
        }
        
        if let root2 {
            val2 = root2.val
        }
        
        let root = TreeNode(val1 + val2)
        
        root.left = mergeTrees(root1?.left, root2?.left)
        root.right = mergeTrees(root1?.right, root2?.right)
        
        return root
    }
    
    func isBalanced(_ root: TreeNode?) -> Bool {
        return height(root) != -1
    }
    
    private func height(_ node: TreeNode?) -> Int {
        guard let node else { return 0 }
        
        let left = height(node.left)
        if left == -1 { return -1 }
        
        let right = height(node.right)
        if right == -1 { return -1 }
        
        if abs(right - left) > 1 { return -1 }
        
        return 1 + max(left, right)
    }
    
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        var best = 0
        _ = depth(root, &best)
        return best
    }
    
    private func depth(_ node: TreeNode?, _ best: inout Int) -> Int {
        guard let node else { return }
        let left = depth(node.left, &best)
        let right = depth(node.right, &best)
        best = max(best, left + right)
        return 1 + max(left, right)
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
