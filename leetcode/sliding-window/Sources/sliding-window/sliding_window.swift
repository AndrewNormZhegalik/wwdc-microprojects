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
    
    func lengthOfLongestSub(_ s: String) -> Int { // Medium
        guard !s.isEmpty else { return 0 }
        
        var longest = 1
        var l = 0
        var array = Array(s)
        var viewed: Set<Character> = []
        
        for r in 0..<array.count {
            while viewed.contains(array[r]) {
                viewed.remove(array[l])
                l += 1
            }
            viewed.insert(array[r])
            longest = max(longest, r - l + 1)
        }
        
        return longest
    }
    
    // Minimum Size Subarray Sum
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        var sum = 0
        var l = 0
        var minimal = Int.max
        
        for r in 0..<nums.count {
            sum += nums[r]
            
            while sum >= target {
                minimal = min(minimal, r - l + 1)
                sum -= nums[l]
                l += 1
            }
        }
        
        return minimal == Int.max ? 0 : minimal
    }
    
    func characterReplacement(_ s: String, _ k: Int) -> Int { // Medium
        var l = 0
        var longest = 0
        var frequency: [Character: Int] = [:]
        let array = Array(s)
        
        for r in 0..<array.count {
            frequency[array[r], default: 0] += 1
            let windowSize = r - l + 1
            let mostFrequent = frequency.values.max() ?? 0
            
            if windowSize - mostFrequent > k {
                frequency[array[l]]? -= 1
                l += 1
            }
            
            longest = max(longest, r - l + 1)
        }
        
        return longest
    }
    
    func minWindow(_ s: String, _ t: String) -> String { // HARD
        var requiredChars: [Character: Int] = [:]
        var windowCount: [Character: Int] = [:]
        var l = 0
        var answer = (length: Int.max, start: 0, end: 0)
        var formed = 0
        
        let sChars = Array(s)
        let tChars = Array(t)
        
        for char in tChars {
            requiredChars[char, default: 0] += 1
        }
        
        let matches = requiredChars.count
        
        for r in 0..<sChars.count {
            let char = sChars[r]
            windowCount[char, default: 0] += 1
            
            if let req = requiredChars[char], windowCount[char]! == req {
                formed += 1
            }
            
            while l <= r, formed == matches {
                let currentLength = r - l + 1
                
                if currentLength < answer.length {
                    answer.length = currentLength
                    answer.start = l
                    answer.end = r
                }
                
                let leftChar = sChars[l]
                windowCount[leftChar]! -= 1
                
                if let req = requiredChars[char], windowCount[leftChar]! < req {
                    formed -= 1
                }
                
                l += 1
            }
        }
        
        if answer.length == Int.max {
            return ""
        } else {
            return String(sChars[answer.start...answer.end])
        }
    }
    
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        var l = 0
        var requiredCharacters: [Character: Int] = [:]
        var windowCount: [Character: Int] = [:]
        
        var sChars = Array(s)
        var pChars = Array(p)
        
        var answer: [Int] = []
        var formed: Int = 0
        
        for char in pChars {
            requiredCharacters[char, default: 0] += 1
        }
        
        for r in 0..<sChars.count {
            let char = sChars[r]
            windowCount[char, default: 0] += 1
            
            if let req = requireCharacters[char], windowCount[char] == req {
                formed += 1
            }
            
            if (r - l + 1) == pChars.count {
                if formed == requiredCharacters.count {
                    answers.append(l)
                }
                
                let char = sChars[l]
                windowCount[char, default: 0] -= 1
                
                if let req = requiredCharacters[char], windowCount[char, default: 0] < req {
                    formed -= 1
                }
                
                l += 1
            }
        }
        
        return answers
    }
    
    //  Permutation in String
    func checkInclusion(_ s1: String, _ s2: String) -> Bool { // Medium
        var l = 0
        let s1Chars = Array(s1)
        let s2Chars = Array(s2)
        
        var requiredChars: [Character: Int] = [:]
        var windowCount: [Character: Int] = [:]
        
        for char in s1Chars {
            requiredChars[char, default: 0] += 1
        }
        
        for r in 0..<s2Chars.count {
            windowCount[s2Chars[r], default: 0] += 1
            
            if r - l + 1 == s1Chars.count {
                if requiredChars == windowCount {
                    return true
                }
                
                let char = windowCount[s2Chars[l]]
                windowCount[char, default: 0] -= 1
                if windowCount[char] == 0 {
                    windowCount.removeValue(forKey: char)
                }
                l += 1
            }
        }
        
        return false
    }
}
