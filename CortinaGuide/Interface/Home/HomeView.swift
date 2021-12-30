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
        Button(action: {
            delegate?.navigateToAR()
        }, label: {
            Text("Verdergaan")
        })
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
