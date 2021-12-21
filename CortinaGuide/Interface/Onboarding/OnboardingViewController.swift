//
//  OnboardingViewController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    
    private let viewModel: OnboardingViewModel
    
    private let pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    let sceneView = OnboardingView()
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = sceneView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var backButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageController()
        
        viewModel.$pages.binding = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.pageViewController.pages = $0.compactMap { page in
                guard let onboardingPageViewController = self.viewModel.getOnboardingStep(page) as? OnboardingPageViewController else { return nil }
                onboardingPageViewController.delegate = self
                return onboardingPageViewController
            }
            
            if $0.count > 1 {
                self.sceneView.pageControl.numberOfPages = $0.count
                self.sceneView.pageControl.currentPage = 0
            }
        }
        
        sceneView.primaryButton.setTitle("Next", for: .normal)
        sceneView.primaryButton.touchUpInside(self, action: #selector(primaryButtonTapped))
        
        setupBackButton()
    }
    
    private func setupBackButton() {
        let config = UIBarButtonItem.Configuration(target: self,
                                                   action: #selector(backButtonTapped),
                                                   content: .text("Back"),
                                                   accessibilityIdentifier: "BackButton",
                                                   accessibilityLabel: "Back")
        backButton = .create(config)
    }
    
    @objc func backButtonTapped() {
        pageViewController.previousPage()
    }

    private func setupPageController() {
        pageViewController.pageViewControllerDelegate = self
        pageViewController.view.backgroundColor = .clear
        pageViewController.view.frame = sceneView.containerView.frame
        sceneView.containerView.addSubview(pageViewController.view)
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        sceneView.pageControl.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    @objc func primaryButtonTapped() {
        if pageViewController.isLastPage {
            viewModel.finishOnboarding()
        } else {
            pageViewController.nextPage()
        }
    }
    
    @objc func valueChanged(_ pageControl: UIPageControl) {
        if pageControl.currentPage > pageViewController.currentIndex {
            pageViewController.nextPage()
        } else {
            pageViewController.previousPage()
        }
    }
}

extension OnboardingViewController: PageViewControllerDelegate {
    func pageViewController(_ pageViewController: PageViewController, didSwipeToPendingViewControllerAt index: Int) {
        navigationItem.leftBarButtonItem = index > 0 ? backButton: nil
    }
}

// MARK: - OnboardingPageViewControllerDelegate

extension OnboardingViewController: OnboardingPageViewControllerDelegate {
    
}
