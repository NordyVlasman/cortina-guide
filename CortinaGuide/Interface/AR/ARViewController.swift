//
//  ARViewController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation
import UIKit
import RealityKit


class ARViewController: UIViewController {

    private let viewModel: ARViewModel
    
    var arView: ARCortinaView = ARCortinaView(frame: .zero, settings: Settings())
    
    // MARK: - Innits
    init(viewModel: ARViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = arView
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    // MARK: - Private
    private func setupView() {
        setupARView()
    }
    
    private func setupARView() {
        arView.setup()
    }
    
}

