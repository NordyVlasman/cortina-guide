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
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var backButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupPageController() {
        pageViewController.pageViewControllerDelegate = self
        pageViewController.view.backgroundColor = .clear
        pageViewController.view.frame = self.view.frame
    }
}

extension OnboardingViewController: PageViewControllerDelegate {
    func pageViewController(_ pageViewController: PageViewController, didSwipeToPendingViewControllerAt index: Int) {
        navigationItem.leftBarButtonItem = index > 0 ? backButton: nil
    }
}
