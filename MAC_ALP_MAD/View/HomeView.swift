//
//  HomeView.swift
//  MAC_ALP_MAD
//
//  Created by Louis Fernando on 30/05/24.
//

import SwiftUI

public struct CustomTabView: View {
    
    public enum TabBarPosition {
        case top
        case bottom
    }
    
    private let tabBarPosition: TabBarPosition
    private let tabText: [String]
    private let tabIconNames: [String]
    private let tabViews: [AnyView]
    
    @State private var selection = 0
    
    public init(tabBarPosition: TabBarPosition, content: [(tabText: String, tabIconName: String, view: AnyView)]) {
        self.tabBarPosition = tabBarPosition
        self.tabText = content.map { $0.tabText }
        self.tabIconNames = content.map { $0.tabIconName }
        self.tabViews = content.map { $0.view }
    }
    
    public var tabBar: some View {
        HStack {
            Spacer()
            ForEach(0..<self.tabText.count, id: \.self) { index in
                HStack {
                    Image(systemName: self.tabIconNames[index])
                    Text(self.tabText[index])
                }
                .padding()
                .foregroundColor(self.selection == index ? Color("redColor(TeWaRa)") : Color.secondary)
                .background(Color.clear)
                .onTapGesture {
                    self.selection = index
                }
            }
            Spacer()
        }
        .background(
            Color.white.opacity(0.05)
        )
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            if self.tabBarPosition == .top {
                tabBar
            }
            tabViews[selection]
                .padding(0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if self.tabBarPosition == .bottom {
                tabBar
            }
        }
        .padding(0)
    }
}

struct HomeView: View {
    var body: some View {
        CustomTabView(
            tabBarPosition: .bottom,
            content: [
                (
                    tabText: "Beranda",
                    tabIconName: "house.fill",
                    view: AnyView(AdditionalQuestionView().navigationBarBackButtonHidden(true))
                ),
                (
                    tabText: "Peringkat",
                    tabIconName: "chart.bar.fill",
                    view: AnyView(AnswerDescriptionView().navigationBarBackButtonHidden(true))
                )
            ]
        )
    }
}

#Preview {
    HomeView()
}
