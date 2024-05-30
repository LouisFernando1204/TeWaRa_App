//
//  ButtonCheck.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 19/05/24.
//

import SwiftUI

struct ButtonCheck: View {
    
    let action: () -> Void
    let message: String
    
    var body: some View {
        Button(action: action) {
            Text(message)
                .fontWeight(.bold)
                .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                .padding(.horizontal, ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth / 3.6 : 100)
                .padding(.vertical, 20)
                .foregroundColor(.white)
                .background(ButtonColor.redButton)
                .cornerRadius(ScreenSize.screenWidth > 600 ? 30 : 35)
        }
        .controlSize(.extraLarge)
        .shadow(color: .red, radius: 2, y: 2)
    }
}
