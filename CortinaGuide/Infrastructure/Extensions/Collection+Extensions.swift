//
//  Collection+Extensions.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 22/12/2021.
//

import Foundation

extension Collection where Element == Float, Index == Int {
    var average: Float? {
        guard !isEmpty else { return nil }
        
        let sum = reduce(Float(0)) { current, next -> Float in
            return current + next
        }
        
        return sum / Float(count)
    }
}
