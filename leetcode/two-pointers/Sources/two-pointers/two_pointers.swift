// The Swift Programming Language
// https://docs.swift.org/swift-book

class Solution {
    func isPalindrome(_ s: String) -> Bool { // Easy
        guard s.count > 0 else { return false }
        
        let newString = s.lowercased()
        var characters: [Character] = []
        
        for char in newString {
            if char.isLetter {
                characters.append(char)
            }
        }
        
        var left = 0
        var right = characters.count - 1
        
        while left < right {
            if characters[left] != characters[right] {
                return false
            }
            
            left += 1
            right -= 1
        }
        
        return true
    }
}
