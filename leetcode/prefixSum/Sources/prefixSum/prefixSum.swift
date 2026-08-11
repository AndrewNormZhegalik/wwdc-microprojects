// The Swift Programming Language
// https://docs.swift.org/swift-book

class Solution {
    // 560. Subarray Sum Equals K
    func subarraySum(_ nums: [Int], _ k: Int) -> Int { // Medium
        var result = 0
        var prefixes = [0: 1]
        var sum = 0
        
        for num in nums {
            sum += num
            
            if let count = prefixes[sum - k] {
                result += count
            }
            
            prefixes[num, default: 0] += 1
        }
        
        return result
    }
    
    // 303. Range Sum Query - Immutable
    class NumArray {
        var prefixes: [Int] = [0]
        
        init(_ nums: [Int]) {
            for num in nums {
                prefixes.append(prefixes.last! + num)
            }
        }
        
        func sumRange(_ left: Int, _ right: Int) -> Int {
            prefixes[right + 1] - prefixes[left]
        }
    }
    
    func longestConsequtive(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        var length: Int = 1
        var start = 0
        
        for i in 1..<nums.count {
            var currentLength = 0
            if nums[i] > nums[i - 1] {
                currentLength = i - start + 1
            } else {
                start = i
                currentLength = 1
            }
            
            length = max(currentLength, length)
        }
        
        return length
    }
    
    //Find Pivot Index
    func pivotIndex(_ nums: [Int]) -> Int { // Easy
        var prefixes: [Int] = [0]
        
        for num in nums {
            prefixes.append(prefixes.last! + num)
        }
        
        for i in 0..<nums.count {
            if prefixes[i] == prefixes[nums.count] - prefixes[i + 1] {
                return i
            }
        }
        
        return -1
    }
}
