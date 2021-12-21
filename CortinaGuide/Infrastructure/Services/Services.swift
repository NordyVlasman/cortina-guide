//
//  Services.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 21/12/2021.
//

import Foundation

final class Services {
    
    private static var onboardingManagingType: OnboardingManaging.Type = OnboardingManager.self
        
    static func use(_ onboardingManaging: OnboardingManaging) {
        onboardingManager = onboardingManaging
    }
    
    static private(set) var onboardingManager: OnboardingManaging = onboardingManagingType.init()
    
}
