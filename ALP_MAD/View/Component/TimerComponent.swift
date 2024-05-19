//
//  TimerComponent.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 19/05/24.
//

import SwiftUI

struct TimerComponent: View {
    
    let type: String
    
    var body: some View {
        Rectangle()
            .fill(CustomGradient.redOrangeGradient)
            .clipShape(RoundedRectangle(cornerRadius: 14.0))
            .frame(
                width: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth / 5 :  ScreenSize.screenWidth / 3,
                height:  ScreenSize.screenWidth > 600 ?  ScreenSize.screenWidth / 18 :  ScreenSize.screenWidth / 10
            )
            .offset(y: (type == "Bahasa" && ScreenSize.screenWidth > 600) ? 150 : (type == "Bahasa" && ScreenSize.screenWidth < 600 ? 94 : 0))
    }
}
