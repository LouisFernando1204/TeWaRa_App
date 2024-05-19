//
//  TextField.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 19/05/24.
//

import SwiftUI

struct TextFieldComponent: View {
    
    @State var value: String
    
    var body: some View {
        TextField("Masukkan jawabanmu...", text: $value)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(
                        CustomGradient.redOrangeGradient,
                        lineWidth: 2
                    )
            )
        Spacer()
            .frame(height: 20)
    }
}

