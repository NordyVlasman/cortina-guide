//
//  OnboardingCoordinator.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import UIKit

protocol OnboardingCoordinatorDelegate: AnyObject {
    func dismiss()
    func finishOnboarding()
    func navigateToConsent()
    func consentGiven()
}

protocol OnboardingDelegate: AnyObject {
    func finishOnboarding()
    func consentGiven()
}

class OnboardingCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var onboardingFactory: OnboardingFactoryProtocol
    
    weak var onboardingDelegate: OnboardingDelegate?
    weak var presentingViewController: UIViewController?
    
    init(navigationController: UINavigationController, onboardingDelegate: OnboardingDelegate, factory: OnboardingFactoryProtocol) {
        self.navigationController = navigationController
        self.onboardingDelegate = onboardingDelegate
        onboardingFactory = factory
        onboardingPages = onboardingFactory.create()
        
    }
    
    var onboardingPages: [OnboardingPage] = []
    
    func start() {
        let viewModel = OnboardingViewModel(coordinator: self, pages: onboardingPages)
        let viewController = OnboardingViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension OnboardingCoordinator: OnboardingCoordinatorDelegate {
    func dismiss() {
        presentingViewController?.dismiss(animated: true, completion: nil)
        presentingViewController = nil
    }

    func finishOnboarding() {
        onboardingDelegate?.finishOnboarding()
        navigateToConsent()
    }

    func navigateToConsent() {
        let viewController = OnboardingConsentViewController(viewModel: OnboardingConsentViewModel(coordinator: self, factory: onboardingFactory))
        navigationController.pushViewController(viewController, animated: true)
    }

    func consentGiven() {
        onboardingDelegate?.consentGiven()
        navigationController.popToRootViewController(animated: false)
    }
}
