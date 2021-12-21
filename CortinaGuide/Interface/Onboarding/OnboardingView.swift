//
//  OnboardingView.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 21/12/2021.
//

import UIKit

class OnboardingView: BaseView {
    
    /// The display constants
    private struct ViewTraits {
        
        // Dimensions
        static let buttonHeight: CGFloat = 52
        
        // Margins
        static let margin: CGFloat = 20.0
        static let pageControlMargin: CGFloat = 12.0
    }
    
    let containerView: UIView = {
       
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pageControl: UIPageControl = {
       
        let view = UIPageControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.pageIndicatorTintColor = .gray
        view.currentPageIndicatorTintColor = .blue
        return view
    }()
    
    let primaryButton = CortinaButton()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
    }
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        
        addSubview(containerView)
        addSubview(pageControl)
        addSubview(primaryButton)
    }
    
    override func setupViewConstraints() {
        super.setupViewConstraints()
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: UIDevice.current.hasNotch ? 0 : -15.0),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            primaryButton.heightAnchor.constraint(greaterThanOrEqualToConstant: ViewTraits.buttonHeight),
            primaryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            primaryButton.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor, constant: ViewTraits.margin),
            primaryButton.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -ViewTraits.margin),
            primaryButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -ViewTraits.margin)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: UIDevice.current.isSmallScreen ? 0 : -ViewTraits.margin),
            pageControl.bottomAnchor.constraint(equalTo: primaryButton.topAnchor, constant: UIDevice.current.isSmallScreen ? 0 : -ViewTraits.pageControlMargin),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
