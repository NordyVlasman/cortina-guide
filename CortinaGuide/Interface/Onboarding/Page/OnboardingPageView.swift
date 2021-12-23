//
//  OnboardingPageView.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 21/12/2021.
//

import SwiftUI

struct OnboardingPageView: View {
    private let viewModel: OnboardingPageViewModel?
    
    weak var delegate: HomeViewDelegate?

    
    init(viewModel: OnboardingPageViewModel? = nil) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
//            Color.purple
//                .ignoresSafeArea()
            VStack {
                
                Spacer ()
                Text ("Fiets in AR")
                    .font(.title)
                    .fontWeight(.black)
                    .padding(.bottom)
                
                
                Text ("Augmented Reality room..")
                    .padding(.bottom, 100)
                
                
                HStack {
                    Circle ()
                        .fill (Color.black)
                        .frame (width:20, height:15)
                        .padding(.bottom, 50)
                    
                    Circle ()
                        .strokeBorder (Color.black, lineWidth: 2)
                        .background(Circle() .fill (Color.white))
                        .frame (width:20, height:15)
                        .padding(.bottom, 50)
                    
                    Circle ()
                        .strokeBorder (Color.black, lineWidth: 2)
                        .background(Circle() .fill (Color.white))
                        .frame (width:20, height:15)
                        .padding(.bottom, 50)
                
                }
                
                   
                    Button(action: {
                        delegate?.navigateToAR()
                    }, label: {
                        Text("Volgende")
                            .fontWeight(.heavy)
                            .foregroundColor(Color.black)
                    })
                        .frame (width: 150, height:60)
                        .background (Color.white)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)

                
                Spacer ()
                
            }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView()
    }
}
 
}
