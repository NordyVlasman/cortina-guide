//
//  OnboardingFactory.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import UIKit

/// The steps of the onboarding
enum OnboardingStep: Int {
    case welcome
    case access
    case finish
}

struct OnboardingPage {
    let title: String
    let message: String
    let image: UIImage?
    let step: OnboardingStep
}

protocol OnboardingFactoryProtocol {
    
    func create() -> [OnboardingPage]
    
    func getConsentTitle() -> String
    
}

struct OnboardingFactory: OnboardingFactoryProtocol {
    
    
    func create() -> [OnboardingPage] {
        let pages = [
            OnboardingPage(title: "Hey 👋", message: "Hello world", image: UIImage(named: "step1"), step: .welcome),
            OnboardingPage(title: "Access 🥺", message: "Hello world", image: UIImage(named: "step1"), step: .access),
            OnboardingPage(title: "Thanks 🚀", message: "Hello world", image: UIImage(named: "step1"), step: .finish),
        ]
        
        return pages.sorted { $0.step.rawValue < $1.step.rawValue }
    }
    
    func getConsentTitle() -> String {
        return "Geef toestemming"
    }
}
