// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

final class Solution {
    func isValid(_ s: String) -> Bool { // Valid paranthesis (Easy)
        guard s.count % 2 == 0 else { return false }
        
        var stack = [Character]()
        
        for char in s {
            switch char {
            case "(": stack.append(")")
            case "{": stack.append("}")
            case "[": stack.append("]")
            default:
                if stack.isEmpty || stack.removeLast() != char {
                    return false
                }
            }
        }
        
        return stack.isEmpty
    }
}
