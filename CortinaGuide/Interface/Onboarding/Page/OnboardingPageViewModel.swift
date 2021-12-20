//
//  OnboardingPageViewModel.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation
import UIKit

class OnboardingPageViewModel {
    weak var coordinator: OnboardingCoordinatorDelegate?
    
    @Bindable private(set) var title: String
    @Bindable private(set) var message: String
    @Bindable private(set) var image: UIImage?
    
    /// Initializer
    /// - Parameters:
    ///   - coordinator: the coordinator delegate
    ///   - onboardingInfo: the container with onboarding info
    init(coordinator: OnboardingCoordinatorDelegate, onboardingInfo: OnboardingPage) {
        self.coordinator = coordinator
        
        title = onboardingInfo.title
        message = onboardingInfo.message
        image = onboardingInfo.image
    }
}
