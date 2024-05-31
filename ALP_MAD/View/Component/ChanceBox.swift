//
//  ChanceBox.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 19/05/24.
//

import SwiftUI

struct ChanceBox: View {
    
    let message: String
    
    var body: some View {
        Rectangle()
            .fill(CustomGradient.redOrangeGradient)
            .clipShape(
                ScreenSize.screenWidth > 600 ? RoundedRectangle(cornerRadius: 35) : RoundedRectangle(cornerRadius: 25.0)
            )
            .frame(
                width: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth / 1.8 : ScreenSize.screenWidth / 1.4,
                height: ScreenSize.screenHeight / 18
            )
            .overlay {
                Text("Kesempatan kamu kurang 3x")
                    .fontWeight(.medium)
                    .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                    .foregroundColor(Color.white)
            }
    }
}
