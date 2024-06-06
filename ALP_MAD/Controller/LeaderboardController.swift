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
    
    func getSortedUserList(for island: Island) -> [User] {
        return island.userList.sorted(by: { $0.score > $1.score })
    }
    
    func getTopThreeUsers(for islandName: String) -> [User] {
        guard let island = getIsland(islandName) else { return [] }
        return getSortedUserList(for: island).prefix(3).map { $0 }
    }
    
    func getUserRank(in islandName: String, userName: String) -> Int? {
        guard let island = getIsland(islandName) else { return nil }
        let sortedUsers = getSortedUserList(for: island)
        return sortedUsers.firstIndex { $0.name == userName }?.advanced(by: 1)
    }
    
    func getTopIsland() -> Island? {
        guard let leaderboard = self.leaderboard else { return nil }
        let islands = [leaderboard.sumatera, leaderboard.kalimantan, leaderboard.papua, leaderboard.java, leaderboard.bali, leaderboard.sulawesi]
        return islands.max { $0.userList.map { $0.score }.reduce(0, +) < $1.userList.map { $0.score }.reduce(0, +) }
    }
    
    func getIsland(_ islandName: String) -> Island? {
        guard let leaderboard = self.leaderboard else { return nil }
        switch islandName {
        case "Sumatera": return leaderboard.sumatera
        case "Kalimantan": return leaderboard.kalimantan
        case "Papua": return leaderboard.papua
        case "Java": return leaderboard.java
        case "Bali": return leaderboard.bali
        case "Sulawesi": return leaderboard.sulawesi
        default: return nil
        }
    }
    
    func updateUserScore(in islandName: String, userName: String, newScore: Int) {
        guard var leaderboard = self.leaderboard,
              var island = getIsland(islandName),
              let index = island.userList.firstIndex(where: { $0.name == userName }) else { return }
        
        island.userList[index].score = newScore
        
        switch islandName {
        case "Sumatera": leaderboard.sumatera = island
        case "Kalimantan": leaderboard.kalimantan = island
        case "Papua": leaderboard.papua = island
        case "Java": leaderboard.java = island
        case "Bali": leaderboard.bali = island
        case "Sulawesi": leaderboard.sulawesi = island
        default: break
        }
    }
    
    func addUser(_ user: User, to islandName: String) {
        guard var leaderboard = self.leaderboard,
              var island = getIsland(islandName) else { return }
        
        island.userList.append(user)
        
        switch islandName {
        case "Sumatera": leaderboard.sumatera = island
        case "Kalimantan": leaderboard.kalimantan = island
        case "Papua": leaderboard.papua = island
        case "Java": leaderboard.java = island
        case "Bali": leaderboard.bali = island
        case "Sulawesi": leaderboard.sulawesi = island
        default: break
        }
    }
    
    func getTraditionalDance(for islandName: String) -> TraditionalDance? {
        return getIsland(islandName)?.traditionalDance
    }
    
    func getTraditionalLanguage(for islandName: String) -> TraditionalLanguage? {
        return getIsland(islandName)?.traditionalLanguage
    }
    
    func accumulateRanking(for islandName: String) {
        guard let island = getIsland(islandName) else { return }
        let totalScore = island.userList.map { $0.score }.reduce(0, +)
        // Here you would update some global ranking or property based on the total score
        // For now, let's just print it
        print("\(islandName) total score: \(totalScore)")
    }
    
    func accumulateJavaRanking() { accumulateRanking(for: "Java") }
    func accumulateKalimantanRanking() { accumulateRanking(for: "Kalimantan") }
    func accumulateSulawesiRanking() { accumulateRanking(for: "Sulawesi") }
    func accumulatePapuaRanking() { accumulateRanking(for: "Papua") }
    func accumulateSumateraRanking() { accumulateRanking(for: "Sumatera") }
    func accumulateBaliRanking() { accumulateRanking(for: "Bali") }
}


