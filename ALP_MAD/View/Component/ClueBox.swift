//
//  ClueBox.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 19/05/24.
//

import SwiftUI

struct ClueBox: View {
    
    let currentIsland: Island
    
    var body: some View {
        Rectangle()
            .clipShape(RoundedRectangle(cornerRadius: 14.0))
            .frame(
                height: ScreenSize.screenWidth > 600 ? ScreenSize.screenHeight / 4 : ScreenSize.screenHeight / 4
            )
            .foregroundColor(.secondary.opacity(0.2))
            .overlay(
                VStack(content: {
                    Text("Petunjuk")
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.black)
                        .font(
                            ScreenSize.screenWidth > 600 ? .title : .headline
                        )
                    
                    Text("'\(currentIsland.traditionalLanguage.clue)'")
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .font(
                            ScreenSize.screenWidth > 600 ? .largeTitle : .title3
                        )
                        .padding(.vertical, 4)
                        .overlay {
                            CustomGradient.redDarkRedGradient
                        }
                        .mask(
                            Text("'\(currentIsland.traditionalLanguage.clue)'")
                                .multilineTextAlignment(.center)
                                .fontWeight(.bold)
                                .font(
                                    ScreenSize.screenWidth > 600 ? .largeTitle : .title3
                                )
                        )

                    Text("Ayo-ayo kamu pasti bisa!!!")
                        .fontWeight(.regular)
                        .font(
                            ScreenSize.screenWidth > 600 ? .title : .headline
                        )
                        .italic()
                        .padding(.bottom)
                        .overlay {
                            CustomGradient.redOrangeGradient
                            .mask(
                                Text("Ayo-ayo kamu pasti bisa!!!")
                                    .fontWeight(.regular)
                                    .font(
                                        ScreenSize.screenWidth > 600 ? .title : .headline
                                    )
                                    .italic()
                                    .padding(.bottom)
                            )
                        }
                    
                })
                .padding(.horizontal, ScreenSize.screenWidth > 600 ? 20 : 10)
            )
    }
}

