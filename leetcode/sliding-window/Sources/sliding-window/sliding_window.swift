// The Swift Programming Language
// https://docs.swift.org/swift-book

class Solution {
    
    func maxProfit(_ prices: [Int]) -> Int { // Easy
        var minBuy = Int.max
        var maxProfit = 0
        
        for price in prices {
            if price < minBuy {
                minBuy = price
            } else {
                maxProfit = max(maxProfit, price - minBuy)
            }
        }
        
        return maxProfit
    }
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard !s.isEmpty else { return 0 }
        var chars = Array(s)
        var l = 0
        var viewed: Set<Character> = []
        var longest: Int = 1
        
        for r in 0..<chars.count {
            while viewed.contains(chars[r]) {
                viewed.remove(chars[l])
                l += 1
            }
            viewed.insert(chars[r])
            longest = max(longest, r - l + 1)
        }
        
        return longest
    }
}
