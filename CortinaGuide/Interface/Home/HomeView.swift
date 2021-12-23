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
                
                Text ("Welke fiets zoek je?")
                    .font(.title)
                    .fontWeight(.black)
                    .padding(.trailing, 100)
                
                Spacer ()
                HStack {
                    Button(action: {
                        delegate?.navigateToAR()
                    }, label: {
                        Text("Stadsfiets")
                            .fontWeight(.heavy)
                            .foregroundColor(Color.black)
                    })
                        .frame (width: 150, height:60)
                        .background (Color.white)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                      
                    
                    Button(action: {
                        delegate?.navigateToAR()
                    }, label: {
                        Text("E bikes")
                            .fontWeight(.heavy)
                            .foregroundColor(Color.black)
                    })
                        .frame (width: 150, height:60)
                        .background (Color.white)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)

                }
                    
                
                Spacer ()
                
            }
    }
//            .background(.purple)
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
