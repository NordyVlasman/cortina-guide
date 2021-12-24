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
                    Button(action: {
                        delegate?.navigateToAR()
                    }, label: {
                        
                    })
                HStack{
                    Knop (text: "Stadsfietsen")
                    Knop (text: "E bikes")
                }
                HStack{
                    Knop (text: "Family bikes")
                    Knop (text: "Damesfietsen")
                }
                HStack{
                    Knop (text: "Transportfietsen")
                    Knop (text: "Herenfietsen")
                }
                HStack{
                    Knop (text: "Kids fietsen")
                    Knop (text: "Sportieve fietsen")
                }
                HStack{
                    Knop (text: "Direct leverbaar")
                    
                    Rectangle ()
                        .fill(Color.white)
                        .frame(width: 200, height: 100)
                       
                }
               
                    Spacer ()
                

                        
        }

    }
       
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
