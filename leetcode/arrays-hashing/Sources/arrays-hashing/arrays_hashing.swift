// The Swift Programming Language
// https://docs.swift.org/swift-book

class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] { // Medium
        let frequencies: [Int: Int] = [:]
        
        for num in nums {
            frequencies[num, default: 0] += 1
        }
        
        return frequencies.sorted { $0.value > $1.value }.prefix(k).map(\.key)
    }
    
    func groupAnagrams(_ strs: [String]) -> [[String]] { // Medium
        let frequencies: [String: [String]] = [:]
        
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
                return 0
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
}
