//
//  TraditionalLanguageView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct TraditionalLanguageView: View {
    
    @Environment(ModelData.self) var modelData
    @State private var textFieldValue: String = ""
    @StateObject private var traditionalLanguageController = TraditionalLanguageController(traditionalLanguage: ModelData().bali.traditionalLanguage)
    
    var body: some View {
        VStack(content: {
            
            HStack(content: {
                Text("'\(modelData.bali.traditionalLanguage.sentences)' merupakan bahasa daerah...")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Spacer()
            })
            .padding(.vertical, 20)
            
            Image(modelData.bali.traditionalLanguage.image)
                .resizable()
                .frame(width: 350, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius:5)
                .padding(.bottom, 20)
            
            TextField("Masukkan jawabanmu...", text: $textFieldValue)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                           startPoint: .leading,
                                           endPoint: .trailing),
                            lineWidth: 2
                        )
                )
            
            Rectangle()
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .frame(height: 210)
                .foregroundColor(.secondary.opacity(0.3))
                .overlay(
                    VStack(content: {
                        Text("Petunjuk")
                            .fontWeight(.semibold)
                            .font(.title3)
                        
                        Text("'\(modelData.bali.traditionalLanguage.clue)'")
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                            .font(.title3)
                            .padding(.vertical, 4)
                        
                        Text("Ayo-ayo kamu pasti bisa!!!")
                            .fontWeight(.semibold)
                            .font(.headline)
                            .italic()
                        
                    })
                    .padding(.horizontal, 10)
                )
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Cek Jawaban")
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                
            })
            .tint(.red)
            
        })
        .padding(.horizontal, 20)
    }
}

#Preview {
    TraditionalLanguageView()
        .environment(ModelData())
}
