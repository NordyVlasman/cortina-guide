//
//  LaunchViewController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation
import UIKit

class LaunchViewController: UIViewController {

    /// The launch view model
    private let viewModel: LaunchViewModel
    
    private let sceneView = LaunchView()
    
    // MARK: - Initializers
    
    /// Initializer
    /// - Parameter viewModel: Launch View Model
    init(viewModel: LaunchViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Required initializer
    /// - Parameter coder: the code
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubSwiftUIView(sceneView, to: view)
    }
}
