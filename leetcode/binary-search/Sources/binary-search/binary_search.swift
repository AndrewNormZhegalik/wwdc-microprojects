// The Swift Programming Language
// https://docs.swift.org/swift-book

class Solution {
    func binarySearch(_ nums: [Int], _ target: Int) -> Int { // Easy
        var l = 0
        var r = nums.count - 1
        
        while l <= r {
            let mid = l + (r - l) / 2
            
            if nums[mid] == target {
                return mid
            } else if nums[mid] > target {
                r = mid - 1
            } else {
                l = mid + 1
            }
        }
        
        return -1
    }
}
