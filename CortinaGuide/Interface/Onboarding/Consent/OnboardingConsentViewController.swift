//
//  OnboardingConsentViewController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import UIKit

final class OnboardingConsentViewController: UIViewController {
    
    let viewModel: OnboardingConsentViewModel
    
    init(viewModel: OnboardingConsentViewModel) {
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
