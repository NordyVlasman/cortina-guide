//
//  SwiftUIViewBikeInfo.swift
//  SwiftUIViewBikeInfo
//
//  Created by mariam on 04/01/2022.
//

import SwiftUI

struct SwiftUIViewBikeInfo: View {
    let name: String
    let price: String
    var body: some View {
        VStack{
            Image ("Cortina Bike")
                .resizable()
                .frame(width: 140, height: 140)
            
            HStack {
                Text(name)
                    .font(.footnote)
                    .padding(.trailing, 40)
                    .frame (width: 150, height: 40)
                    .multilineTextAlignment(.leading)

            }
            
            Text(price)
                .font(.footnote)
                .padding(.trailing, 100)
                .frame (width: 160, height: 10)
                .foregroundColor(Color.black
                                    .opacity(0.45))
        }
    }
}

struct SwiftUIViewBikeInfo_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            SwiftUIViewBikeInfo (name: "Cortina Common Family", price: "€2399")
            SwiftUIViewBikeInfo (name: "Cortina Common Family", price: "€2399")

        }
        
    }
}

    
    
