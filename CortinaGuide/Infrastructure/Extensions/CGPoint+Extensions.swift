//
//  CGPoint+Extensions.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 22/12/2021.
//

import Foundation
import SceneKit

extension CGPoint {
    init(_ vector: SCNVector3) {
        self.init(x: CGFloat(vector.x), y: CGFloat(vector.y))
    }
    
    var length: CGFloat {
        return sqrt(x * x + y * y)
    }
}
