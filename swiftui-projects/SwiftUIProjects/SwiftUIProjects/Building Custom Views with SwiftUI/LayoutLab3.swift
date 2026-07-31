//
//  Untitled.swift
//  SwiftUIProjects
//
//  Created by Andrey on 29.07.2026.
//

import SwiftUI

struct LayoutLab3: View {
    var body: some View {
        Text("hi")
            .frame(width: 200, height: 100, alignment: .trailing)
            .border(.green)
    }
}

class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
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
        
        return l
    }
}
