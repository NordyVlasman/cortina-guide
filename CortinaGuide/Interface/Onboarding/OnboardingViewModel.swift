//
//  OnboardingViewModel.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import UIKit

class OnboardingViewModel {
    weak var coordinator: OnboardingCoordinatorDelegate?
 
    @Bindable private(set) var pages: [OnboardingPage]
    @Bindable private(set) var enabled: Bool
    
    init(coordinator: OnboardingCoordinatorDelegate, pages: [OnboardingPage]) {
        self.coordinator = coordinator
        self.pages = pages
        self.enabled = true
    }
    
    func getOnboardingStep(_ info: OnboardingPage) -> UIViewController {
        let viewController = OnboardingPageViewController(
            viewModel: OnboardingPageViewModel(
                coordinator: self.coordinator!,
                onboardingInfo: info
            )
        )
        viewController.isAccessibilityElement = true
        return viewController
    }
    
    func finishOnboarding() {
        coordinator?.finishOnboarding()
    }
}
