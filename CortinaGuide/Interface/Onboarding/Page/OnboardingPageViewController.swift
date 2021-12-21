//
//  OnboardingPageViewController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import UIKit

class OnboardingPageViewController: UIViewController {
    
    private let viewModel: OnboardingPageViewModel
    
    init(viewModel: OnboardingPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
