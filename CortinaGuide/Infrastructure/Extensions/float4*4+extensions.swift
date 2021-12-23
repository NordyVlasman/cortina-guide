//
//  float4*4+extensions.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 22/12/2021.
//

import Foundation
import ARKit

extension float4x4 {
    var translation: SIMD3<Float> {
        get {
            let translation = columns.3
            return [translation.x, translation.y, translation.z]
        }
        set {
            columns.3 = [newValue.x, newValue.y, newValue.z, columns.3.w]
        }
    }
    
    var orientation: simd_quatf {
        return simd_quaternion(self)
    }
}
