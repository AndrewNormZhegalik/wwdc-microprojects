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
    
    func productExceptSelf(_ nums: [Int]) -> [Int] { // Medium
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
    
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] { // Medium Two Sum 2
        var l = 0
        var r = numbers.count - 1
        
        while l < r {
            let sum = numbers[l] + numbers[r]
            
            if sum == target {
                return [l + 1, r + 1]
            } else if sum < target {
                l += 1
            } else {
                r += 1
            }
        }
        
        return []
    }
    
    func threeSum(_ nums: [Int]) -> [[Int]] { // Medium Three sum
        var result: [[Int]] = []
        let sortedArray = nums.sorted()
        
        for (index, num) in sortedArray.enumerated() {
            var l = index + 1
            var r = sortedArray.count - 1
            
            if index > 0 && num == sortedArray[index - 1] {
                continue
            }
            
            while l < r {
                let sum = num + sortedArray[l] + sortedArray[r]
                
                if sum == 0 {
                    result.append([num, sortedArray[l], sortedArray[r]])
                    
                    while l < r && sortedArray[l] == sortedArray[l + 1] {
                        l += 1
                    }
                    
                    while l < r && sortedArray[r] == sortedArray[r - 1] {
                        r -= 1
                    }
                    
                    l += 1
                    r -= 1
                } else if sum < 0 {
                    l += 1
                } else {
                    r -= 1
                }
            }
        }
        
        return result
    }
}
