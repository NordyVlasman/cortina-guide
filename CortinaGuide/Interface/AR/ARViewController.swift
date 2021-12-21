//
//  ARViewController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation
import UIKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    let sceneView = ARSCNView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "AR"
        
        view.addSubview(sceneView)
        
        setupView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration, options: [])
    }
    
    // MARK: - Private
    private func setupView() {
        setupSceneView()
    }
    
    private func setupSceneView() {
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
