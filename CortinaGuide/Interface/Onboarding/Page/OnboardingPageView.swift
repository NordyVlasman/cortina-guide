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
            HStack {
                VStack {
                    Text(viewModel?.title ?? "Welkom")
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                    Text(viewModel?.message ?? "Test message")
                        .font(.headline)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                }
            }.padding(30)
        }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView()
    }
}
 
