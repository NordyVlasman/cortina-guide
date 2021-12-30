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
    
    private enum Policy {
        case privacy
        case policy
    }
    
    @State private var acceptedPrivacy: Bool = false
    @State private var acceptedPolicy: Bool = false
    
    @State private var buttonEnabled: Bool = false
    
    var body: some View {
        VStack {
            Text("Privacybeleid en \n algemene voorwaarden")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Spacer()
            VStack() {
                Button(action: {
                    enableButton(policy: .privacy)
                }, label: {
                    HStack {
                        Image(systemName: "hand.raised.square")
                            .foregroundColor(.blue)
                            .font(.largeTitle)
                        Text("Ik heb het privacybeleid \n doorgelezen en ik snap het.")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                        Spacer()
                        Circle()
                            .strokeBorder(.blue, lineWidth: 3)
                            .background(!acceptedPrivacy ? Circle().fill(.clear) : Circle().fill(.blue))
                            .frame(width: 35, height: 35, alignment: .center)
                    }
                })
                Button(action: {
                    enableButton(policy: .policy)
                }, label: {
                    HStack {
                        Image(systemName: "shield.lefthalf.filled")
                            .foregroundColor(.blue)
                            .font(.largeTitle)
                        Text("Ik ga akkoord \n met de voorwaarden")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                        Spacer()
                        Circle()
                            .strokeBorder(.blue, lineWidth: 3)
                            .background(!acceptedPolicy ? Circle().fill(.clear) : Circle().fill(.blue))
                            .frame(width: 35, height: 35, alignment: .center)
                    }
                })
                .padding(.top, 10)
            }
            Spacer()
            Button(action: {
                delegate?.didFinish()
            }, label: {
                Text("Volgende")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(15)
            })
            .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
            .background(buttonEnabled ? .blue : .gray.opacity(0.4))
            .disabled(!buttonEnabled)
            .cornerRadius(4)
        }
        .padding(.horizontal, 20)
    }
    
    private func enableButton(policy: Policy) {
        switch policy {
        case .privacy:
            acceptedPrivacy = true
        case .policy:
            acceptedPolicy = true
        }
        
        if acceptedPolicy && acceptedPrivacy {
            buttonEnabled = true
        }
    }
}
