// The Swift Programming Language
// https://docs.swift.org/swift-book

class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] { // Medium
        var frequencies: [Int: Int] = [:]
        
        for num in nums {
            frequencies[num, default: 0] += 1
        }
        
        return frequencies.sorted { $0.value > $1.value }.prefix(k).map(\.key)
    }
    
    func groupAnagrams(_ strs: [String]) -> [[String]] { // Medium
        var frequencies: [String: [String]] = [:]
        
        for str in strs {
            let newStr = String(str.sorted())
            frequencies[newStr, default: []].append(str)
        }
        
        return Array(frequencies.values)
    }
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] { // Easy
        guard !nums.isEmpty else { return [] }
        
        var viewed: [Int: Int] = [:]
        
        for (index, num) in nums.enumerated() {
            if let value = viewed[target - num] {
                return [value, index]
            }
            
            viewed[num] = index
        }
        
        return []
    }
    
    func isAnagram(_ s: String, _ t: String) -> Bool { // Easy
        guard s.count == t.count else { return false }
        
        var viewed: [Character: Int] = [:]
        
        for char in s {
            viewed[char, default: 0] += 1
        }
        
        for char in t {
            viewed[char, default: 0] -= 0
        }
        
        for value in viewed.values {
            if value != 0 {
                return false
            }
        }
        
        return true
    }
    
    func containsDuplicate(_ nums: [Int]) -> Bool { // Easy
        var viewed = Set<Int>()
        
        for num in nums {
            if viewed.contains(num) {
                return true
            }
            
            viewed.insert(num)
        }
        
        return false
    }
    
    func isValidSudoku(_ board: [[Character]]) -> Bool { // Bool
        for i in 0..<9 {
            var viewed = Set<Character>()
            for j in 0..<9 {
                if board[i][j] != ".", viewed.contains(board[i][j]) {
                    return false
                }
                viewed.insert(board[i][j])
            }
        }
        
        for j in 0..<9 {
            var viewed = Set<Character>()
            for i in 0..<9 {
                if board[i][j] != ".", viewed.contains(board[i][j]) {
                    return false
                }
                viewed.insert(board[i][j])
            }
        }
        var array: Array<Int> = [1, 2, 3, 4]
        for k in 0..<9 {
            var viewed = Set<Character>()
            for i in k / 3 * 3 ..< k / 3 * 3 + 3 {
                for j in k % 3 * 3 ..< k % 3 * 3 + 3 {
                    if board[i][j] != ".", viewed.contains(board[i][j]) {
                        return false
                    }
                    viewed.insert(board[i][j])
                }
            }
        }
        
        return true
    }
    
    // Longest Consecutive sequence
    func longestConsecutive(_ nums: [Int]) -> Int { // Medium if !numbers.contains(num - 1) ruleeeee!!!!
        var numbers: Set<Int> = Set(nums)
        var maxResult: Int = 0
        
        for num in numbers {
            if !numbers.contains(num - 1) {
                var currentNum = num
                var currentResult = 1
                
                while numbers.contains(num + 1) {
                    currentNum += 1
                    currentResult += 1
                }
                
                maxResult = max(currentResult, maxResult)
            }
        }
        
        return maxResult
    }
}
