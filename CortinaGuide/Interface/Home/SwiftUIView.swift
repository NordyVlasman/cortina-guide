//
//  Knop.swift
//  Knop
//
//  Created by mariam on 23/12/2021.
//

import SwiftUI

struct Knop: View {
    let text: String
    var body: some View {
    VStack{
        HStack {
            Text(text)
                .font(.body)
                .fontWeight(.bold)
                .frame (width: 154, height: 97)
                .background(Color.white)
                .border(Color.black, width: 2)
                .padding(0)
           
//            Rectangle ()
//                .fill(Color.white)
//                .frame(width: 10, height: 10)
//                .padding(0)
                }
            Rectangle ()
                .fill(Color.white)
                .frame(width:200, height: 10)
                .padding(0)
           
        }
    }
}

struct Knop_Previews: PreviewProvider {
    static var previews: some View {
        Knop (text: "Hoi")
    }
}


