//
//  HomeViewController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel: HomeViewModel
    
    private var sceneView = HomeView()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        title = "Dashboard"
        
        addSubSwiftUIView(sceneView, to: view)
    }
}

extension HomeViewController: HomeViewDelegate {
    func navigateToAR() {
        viewModel.didTapShowAR()
    }
}
