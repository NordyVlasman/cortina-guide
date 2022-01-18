//
//  HomeViewCollection.swift
//  HomeViewCollection
//
//  Created by mariam on 24/12/2021.
//

import SwiftUI

struct HomeViewCollection: View {
    var body: some View {
        VStack {
            HStack{
                Rectangle ()
                    .fill(Color.red)
                    .frame(width: 20, height:20 )
                Text("Terug")
                    .foregroundColor(Color("systemBlueColor"))
                
                Text("E Bikes")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 40.0)

                Spacer ()
            }
            
            HStack{
                Text("Prijs")
                    .font(.body)
                    .foregroundColor(Color("systemBlueColor"))
                    .padding()
                    .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray
                                    .opacity(0.50)
                                , lineWidth: 1))
                    .background(Color.gray
                                    .opacity(0.15))
                FilterKnop (text: "Kleur")
                FilterKnop (text: "Framehoogte")

            }
            
            Spacer ()
            
            HStack {
                SwiftUIViewBikeInfo (name: "Cortina Common Family", price: "€2399")
                SwiftUIViewBikeInfo (name: "Cortina Common Family", price: "€2399")
            }
            HStack {
                SwiftUIViewBikeInfo (name: "Cortina Common Family", price: "€2399")
                SwiftUIViewBikeInfo (name: "Cortina Common Family", price: "€2399")
            }
            Spacer ()
            
        }
    }
}

struct HomeViewCollection_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewCollection()
    }
}
