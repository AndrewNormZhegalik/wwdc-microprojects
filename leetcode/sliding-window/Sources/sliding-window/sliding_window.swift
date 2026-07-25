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
}
