//
//  ButtonCheck.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 19/05/24.
//

import SwiftUI

struct ButtonCheck: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Cek Jawaban")
                .fontWeight(.bold)
                .font(ScreenSize.screenWidth > 600 ? .title : .title3)
                .padding(.horizontal, ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth / 3.6 : 120)
                .padding(.vertical, 20)
                .foregroundColor(.white)
                .background(.red)
                .cornerRadius(ScreenSize.screenWidth > 600 ? 30 : 35)
        }
        .controlSize(.extraLarge)
        .shadow(color: .red, radius: 2, y: 2)
    }
}
