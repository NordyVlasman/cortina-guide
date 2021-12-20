//
//  HomeViewController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var sceneView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubSwiftUIView(sceneView, to: self.view)
    }
}
