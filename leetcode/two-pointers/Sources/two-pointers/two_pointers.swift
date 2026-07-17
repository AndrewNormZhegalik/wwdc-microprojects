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
    
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var result: [Int] = []
        
        var l = 0
        var counter = 1
        
        while l < nums.count {
            result.append(counter)
            counter *= nums[l]
            l += 1
        }
        
        counter = 1
        var r = result.count - 1
        
        while r >= 0 {
            result[r] = counter * result[r]
            counter = counter * nums[r]
            r -= 1
        }
        
        return result
    }
}
