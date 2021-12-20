//
//  OnboardingConsentViewModel.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation

final class OnboardingConsentViewModel {
    weak var coordinator: OnboardingCoordinatorDelegate?
    
    var factory: OnboardingFactoryProtocol
    
    init(coordinator: OnboardingCoordinatorDelegate, factory: OnboardingFactoryProtocol) {
        self.coordinator = coordinator
        self.factory = factory
    }
}
