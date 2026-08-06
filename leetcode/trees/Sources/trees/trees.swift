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
    
    func mergeTrees(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? { // Easy
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
    
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int { // Easy
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
    
    // Medium O(h) - for not balanced trees, O(logn) - for balanced trees (Binary Search Tree)
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root, let pVal = p?.value, let qVal = q?.val else { return nil }
        
        if pVal < root.val && qVal < root.val {
            return lowestCommonAncestor(root.left, p, q)
        } else if pVal > root.val && qVal > root.val {
            return lowestCommonAncestor(root.right, p, q)
        }
        
        return root
    }
    
    // Medium Binary Tree (not Binary Search Tree) O(n) because we go through tree leaves
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root else { return nil }
        
        if root === p || root === q {
            return root
        }
        
        let left = lowestCommonAncestor(root.left, p, q)
        let right = lowestCommonAncestor(root.right, p, q)
        
        if left != nil && right != nil {
            return root
        }
        
        return left ?? right
    }
    
    func isSymmetric(_ root: TreeNode?) -> Bool { // Easy
        return isMirror(root?.left, root?.right)
    }
    
    func isMirror(_ a: TreeNode?, _ b: TreeNode?) -> Bool {
        if a == nil && b == nil {
            return true
        }
        
        guard let a, let b, a.val == b.val else { return false }
        
        return isMirror(a.left, b.right) && isMirror(a.right, b.left)
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        return isValid(root, min: nil, max: nil)
    }
    
    private func isValid(_ node: TreeNode?, min: Int?, max: Int?) -> Bool {
        guard let node else { return true }
        
        if let min, node.val <= min {
            return false
        }
        
        if let max, node.val >= max {
            return false
        }
        
        return isValid(node.left, min: min, max: node.val) && isValid(node.right, min: node.val, max: max)
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
