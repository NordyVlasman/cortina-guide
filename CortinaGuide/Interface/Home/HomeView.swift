//
//  HomeView.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import SwiftUI

protocol HomeViewDelegate: AnyObject {
    func navigateToAR()
}

struct HomeView: View {
    
    weak var delegate: HomeViewDelegate?
    
    var body: some View {
        VStack {
            Button(action: {
                delegate?.navigateToAR()
            }, label: {
                Text("Show IN AR")
            })
        }
    }
}
