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
        Text("Hello, World!")
            .background()
    }
}

struct Knop_Previews: PreviewProvider {
    static var previews: some View {
        Knop (text: "Hoi")
    }
}
