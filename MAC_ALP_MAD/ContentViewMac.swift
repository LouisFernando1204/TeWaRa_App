//
//  ContentView.swift
//  MAC_ALP_MAD
//
//  Created by MacBook Pro on 15/05/24.
//

import SwiftUI

struct ContentViewMac: View {
    @State private var isAccess = false
    
    var body: some View {
        Group {
            if self.isAccess {
                PreAlertViewMac()
                    .transition(.opacity)
            } else {
                SplashScreenViewMac()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.isAccess = true
                }
            }
        }
//        HomeViewMac()
    }
}

#Preview {
    ContentViewMac()
}
