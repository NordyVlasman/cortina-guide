//
//  ARViewController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation
import UIKit
import SwiftUI

class ARViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "AR"
        
        addSubSwiftUIView(ARView(), to: view)
    }
    
    
}

struct ARView: View {
    var body: some View {
        Text("AR")
    }
}
