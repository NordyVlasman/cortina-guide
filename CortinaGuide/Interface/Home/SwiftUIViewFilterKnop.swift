//
//  SwiftUIViewFilterKnop.swift
//  SwiftUIViewFilterKnop
//
//  Created by mariam on 24/12/2021.
//

import SwiftUI

struct FilterKnop: View {
    let text: String
    var body: some View {
        VStack{
            HStack {
                Text(text)
                    .font(.body)
//                    .fontWeight(.regular)
//                    .frame (width: 57, height: 48)
                    .padding()
                    .background(Color.gray
                                    .opacity(0.15))
                    .cornerRadius(5)

            }
        }
    }
}

struct FilterKnop_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            FilterKnop (text: "Prijs")
            FilterKnop (text: "Kleur")
            FilterKnop (text: "Framehoogte")
          
        }
        
    }
}

    
        
