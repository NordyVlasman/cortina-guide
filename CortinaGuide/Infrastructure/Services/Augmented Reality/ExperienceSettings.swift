//
//  ExperienceSettings.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 14/01/2022.
//

import Foundation
import CoreGraphics

extension Cortina {
    struct ExperienceSettings {
        let numberOfLevels = 4
        let uiAnimationDuration: TimeInterval = 0.33
        let frameSettleDelay: TimeInterval = 1.5
        let stuckFrameDelay: TimeInterval = 5.0
        let pinTipThreshold: Float = 0.1
        let goodFrameThreshold = 8
        let ballPlayDistanceThreshold: Float = 0.5
        let ballVelocityMinX: Float = -0.8
        let ballVelocityMaxX: Float = 0.8
        let ballVelocityMinZ: Float = -4.0
        let ballVelocityMaxZ: Float = 0.1
    }
}
