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
    case show
    case style
    case finish
}

struct OnboardingPage {
    let title: String
    let message: String
    let image: UIImage?
    let buttonText: String
    let step: OnboardingStep
}

protocol OnboardingFactoryProtocol {
    
    func create() -> [OnboardingPage]
    
    func getConsentTitle() -> String
    
}

struct OnboardingFactory: OnboardingFactoryProtocol {
    
    
    func create() -> [OnboardingPage] {
        let pages = [
            OnboardingPage(title: "Welkom bij \n Cortina experience", message: "Plaats jouw favoriete Cortina fiets in je woonkamer via Augmented Reality en bekijk hem van alle kanten.", image: UIImage(named: "step1"), buttonText: "Beginnen", step: .welcome),
            OnboardingPage(title: "Bekijk een fiets in Augmented Reality", message: "", image: UIImage(named: "step1"), buttonText: "Volgende", step: .show),
            OnboardingPage(title: "Style jouw \n favoriete fiets", message: "", image: UIImage(named: "step1"), buttonText: "Volgende", step: .style),
            OnboardingPage(title: "Kom je er niet uit? \n Gebruik onze keuzehulp", message: "", image: UIImage(named: ""), buttonText: "Volgende", step: .finish)
        ]
        
        return pages.sorted { $0.step.rawValue < $1.step.rawValue }
    }
    
    func getConsentTitle() -> String {
        return "Geef toestemming"
    }
}
