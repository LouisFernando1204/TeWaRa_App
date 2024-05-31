//
//  AnswerBox.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 19/05/24.
//

import SwiftUI

struct AlphabetBox: View {
    
    let type: String
    let alphabet: String
    let isClicked: Bool
    
    var body: some View {
        
        switch type {
        case "Answer" :
            self.showAnswerBox()
        case "Option" :
            self.showOptionBox()
        default :
            self.showErrorDetail()
        }
        
    }
    
    private func showAnswerBox() -> some View {
        Rectangle()
            .frame(
                width: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth / 10 : ScreenSize.screenWidth / 8,
                height: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth / 10 : ScreenSize.screenWidth / 8
            )
            .foregroundColor(.secondary)
            .opacity(0.2)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        CustomGradient.redOrangeGradient,
                        lineWidth: 2
                    )
                    .overlay {
                        if isClicked {
                            Text(alphabet)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                        }
                    }
            )
            .padding(.horizontal, ScreenSize.screenWidth > 600 ? 10 : 1)
            .padding(.vertical)
    }
    
    private func showOptionBox() -> some View {
        Rectangle()
            .frame(
                width: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth / 10 : ScreenSize.screenWidth / 8,
                height: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth / 10 : ScreenSize.screenWidth / 8
            )
            .overlay {
                if !isClicked {
                    CustomGradient.redDarkRedGradient
                }
                else {
                    Color.white
                }
                
            }
            .overlay {
                if !isClicked {
                    Text(alphabet)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
                
            }
            .cornerRadius(10)
            .padding(.horizontal, 3)
    }
    
    private func showErrorDetail() -> some View {
        VStack(content: {
            Text("404 Error!")
        })
    }
    
}

