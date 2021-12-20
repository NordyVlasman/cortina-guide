//
//  HomeViewController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation
import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let childView = UIHostingController(rootView: HomeView())
        addChild(childView)
        childView.view.frame = self.view.frame
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
