//
//  OnboardingManager.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation

protocol OnboardingManaging: AnyObject {
    
    init()
    
    var needsOnboarding: Bool { get }
    
    var needsConsent: Bool { get }
    
    func finishOnboarding()
    
    func consentGiven()

    func reset()
}

class OnboardingManager: OnboardingManaging {
    
    private struct OnboardingData: Codable {
        var needsOnboarding: Bool
        
        var needsConsent: Bool
        
        static var empty: OnboardingData {
            return OnboardingData(needsOnboarding: true, needsConsent: true)
        }
    }
    
    private struct Constants {
        static let keychainService = "OnboardingManager"
    }
    
    @Keychain(name: "onboardingData", service: Constants.keychainService, clearOnReinstall: true)
    private var onboardingData: OnboardingData = .empty
    
    required init() {
        
    }
    
    var needsOnboarding: Bool {
        return onboardingData.needsOnboarding
    }
    
    var needsConsent: Bool {
        return onboardingData.needsConsent
    }
    
    func finishOnboarding() {
        onboardingData.needsOnboarding = false
    }
    
    func consentGiven() {
        onboardingData.needsConsent = false
    }
    
    func reset() {
        $onboardingData.clearData()
    }
}
