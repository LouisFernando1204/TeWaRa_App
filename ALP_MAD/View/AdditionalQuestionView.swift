//
//  AnswerDescriptionView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct AdditionalQuestionView: View {
    
    @StateObject private var islandController = IslandController(island: ModelData.shared.sulawesi)
    
    @State private var answer : String = ""
    
    @State private var isActive : Bool = false
    
    @State var countDownTimer = 30
    
    @State var timerRunning = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack(alignment: .center, content: {
                Text("Bonus")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("redColor(TeWaRa)"))
                    .font(.headline)
            })
            ZStack(alignment: .center, content: {
                Image("backgroundTimer")
                    .resizable()
                    .frame(width: 342, height: 175)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color("redColor(TeWaRa)"), Color("orangeColor(TeWaRa)")]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 4
                            )
                    )
                    .cornerRadius(10)
                Rectangle()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: 334, height: 168)
                    .cornerRadius(6)
                
                Text("00:00:\(countDownTimer)")
                    .onReceive(timer) { _ in
                        if countDownTimer > 0 && timerRunning {
                            countDownTimer -= 1
                        }
                        else {
                            timerRunning = false
                        }
                    }
                    .font(.system(size: 44, weight: .black))
            })
            .padding(.bottom, 10)
            Text("Budaya tersebut berasal dari provinsi...")
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.leading)
        }
        .onAppear{
            timerRunning = true
        }
    }
}
#Preview {
    AdditionalQuestionView()
}
