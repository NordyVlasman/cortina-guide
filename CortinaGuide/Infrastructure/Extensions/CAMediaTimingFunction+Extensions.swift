//
//  CAMediaTimingFunction+Extensions.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 22/12/2021.
//

import SceneKit

extension CAMediaTimingFunction {
    
    static let linear = CAMediaTimingFunction(controlPoints: 0, 0, 1, 1)

    static let easeIn = CAMediaTimingFunction(controlPoints: 0.9, 0, 0.9, 1)

    static let easeOut = CAMediaTimingFunction(controlPoints: 0.1, 0, 0.1, 1)

    static let easeInOut = CAMediaTimingFunction(controlPoints: 0.45, 0, 0.55, 1)
    
    static let easeInEaseOut = CAMediaTimingFunction(controlPoints: 0.42, 0, 0.58, 1)

    static let explodingEaseOut = CAMediaTimingFunction(controlPoints: 0, 0, 0, 1)

    static let `default` = CAMediaTimingFunction(controlPoints: 0, 0, 0.2, 1)
}
