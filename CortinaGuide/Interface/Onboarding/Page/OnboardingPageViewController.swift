//
//  OnboardingPageViewController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import UIKit
import SwiftUI

protocol OnboardingPageViewControllerDelegate: AnyObject {
    
}

class OnboardingPageViewController: UIViewController {
    
    private let viewModel: OnboardingPageViewModel
    
    weak var delegate: OnboardingPageViewControllerDelegate?
    
    init(viewModel: OnboardingPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubSwiftUIView(PageView(), to: view)
    }
}

struct PageView: View {
    var body: some View {
            Text("hekl")
    }
}
