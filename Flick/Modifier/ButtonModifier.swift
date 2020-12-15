//
//  ButtonModifier.swift
//  Flick
//
//  Created by Gruber, John David on 12/1/20.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Capsule().fill(Color.orange))
            .foregroundColor(Color.white)
    }
}


