//
//  OnboardingPageView.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 21/12/2021.
//

import SwiftUI

struct OnboardingPageView: View {
    private let viewModel: OnboardingPageViewModel?
    
    init(viewModel: OnboardingPageViewModel? = nil) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text(viewModel?.title ?? "Test title")
            Text(viewModel?.message ?? "Test message")
        }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView()
    }
}
