//
//  BaseView.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 21/12/2021.
//

import UIKit

class BaseView: UIView {
    
    /// Initializer
    /// - Parameter frame: the frame for the view
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupViews()
        setupViewHierarchy()
        setupViewConstraints()
    }
    
    /// Required initializer
    /// - Parameter aDecoder: decoder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
        setupViewHierarchy()
        setupViewConstraints()
    }
    
    /// Setup all the views
    func setupViews() {
        //
    }
    
    /// Setup the view hierarchy
    func setupViewHierarchy() {
        //
    }
    
    /// Setup all the constraints
    func setupViewConstraints() {
        // 
    }
}
