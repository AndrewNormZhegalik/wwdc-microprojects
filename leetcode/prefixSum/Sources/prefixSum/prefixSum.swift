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
}
