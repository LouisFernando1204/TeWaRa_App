//
//  LeaderboardController.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation
import UIKit
import SwiftUI

class LeaderboardController: ObservableObject {
    
    @Published private(set) var leaderboard: Leaderboard?
    @Published private(set) var user: User
    @Published private(set) var userList: [User] = []
    
    init() {
        let dummyUser = User(name: "Dummy", image: "dummy", score: 0)
        self.user = dummyUser
        
        if let leaderboard = self.loadLeaderboardData() {
            self.leaderboard = leaderboard
            self.userList = leaderboard.sumatera.userList +
                            leaderboard.kalimantan.userList +
                            leaderboard.papua.userList +
                            leaderboard.java.userList +
                            leaderboard.bali.userList +
                            leaderboard.sulawesi.userList
        } else {
            fatalError("Failed to load leaderboard data")
        }
    }
    
    func loadLeaderboardData() -> Leaderboard? {
        guard let sumatera = loadIslandData(from: "SumateraData"),
              let kalimantan = loadIslandData(from: "KalimantanData"),
              let papua = loadIslandData(from: "PapuaData"),
              let java = loadIslandData(from: "JavaData"),
              let bali = loadIslandData(from: "BaliData"),
              let sulawesi = loadIslandData(from: "SulawesiData") else {
            return nil
        }
        
        return Leaderboard(
            sumatera: sumatera,
            kalimantan: kalimantan,
            papua: papua,
            java: java,
            bali: bali,
            sulawesi: sulawesi
        )
    }
    
    private func loadIslandData(from filename: String) -> Island? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let island = try? JSONDecoder().decode(Island.self, from: data) else {
            return nil
        }
        return island
    }
    
    func navigateToHomeView() {
        // Implement navigation logic here
    }
    
    func getLeaderboard() -> Leaderboard? {
        return self.leaderboard
    }
    
    func accumulateJavaRanking() {
        // Implement ranking logic for Java
    }
    
    func accumulateKalimantanRanking() {
        // Implement ranking logic for Kalimantan
    }
    
    func accumulateSulawesiRanking() {
        // Implement ranking logic for Sulawesi
    }
    
    func accumulatePapuaRanking() {
        // Implement ranking logic for Papua
    }
    
    func accumulateSumateraRanking() {
        // Implement ranking logic for Sumatera
    }
    
    func accumulateBaliRanking() {
        // Implement ranking logic for Bali
    }
}


