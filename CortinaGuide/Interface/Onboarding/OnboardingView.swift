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
        
        enum Spacing {
            static let button: CGFloat = 48
        }
        
        enum Margin {
            static let edge: CGFloat = 20
        }
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
        view.currentPageIndicatorTintColor = .systemBlue
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
            containerView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            containerView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor
            ),
            containerView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor
            ),
            
            primaryButton.centerXAnchor.constraint(
                equalTo: centerXAnchor
            ),
            primaryButton.topAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: ViewTraits.Spacing.button
            ),
            primaryButton.heightAnchor.constraint(greaterThanOrEqualToConstant: ViewTraits.buttonHeight),
            primaryButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 10),
            primaryButton.trailingAnchor.constraint(
                lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -ViewTraits.Margin.edge
            ),
            primaryButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -ViewTraits.Margin.edge
            )
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
