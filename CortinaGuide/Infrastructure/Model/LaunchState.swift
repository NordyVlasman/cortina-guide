//
//  LaunchState.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation

enum LaunchState: Equatable {
    
    /// The app is alrighty
    case noActionNeeded
    /// The app needs internet
    case internetRequired
    
    // MARK: - Equatable
    
    /// Equatable
    /// - Parameters:
    ///   - lhs: the left hand
    ///   - rhs: the right hand side
    /// - Returns: True if both sides are equal
    static func == (lhs: LaunchState, rhs: LaunchState) -> Bool {
        switch (lhs, rhs) {
        case (noActionNeeded, noActionNeeded):
            return true
        case (internetRequired, internetRequired):
            return true
            
        default:
            return false
        }
    }
}
