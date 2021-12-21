//
//  OnboardingConsentViewController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import UIKit
import SwiftUI

protocol ConsentViewDelegate: AnyObject {
    func didFinish()
}

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
        addSubSwiftUIView(ConsentView(delegate: self), to: view)
    }
}

extension OnboardingConsentViewController: ConsentViewDelegate {
    func didFinish() {
        viewModel.coordinator?.consentGiven()
    }
}

struct ConsentView: View {
    weak var delegate: ConsentViewDelegate?
    
    var body: some View {
        Text("Consent")
        Button(action: {
            delegate?.didFinish()
        }, label: {
            Text("Yo")
        })
    }
}
