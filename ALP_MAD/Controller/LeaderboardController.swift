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
    }
    
    private func loadIslandData(from filename: String) -> Island? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let island = try? JSONDecoder().decode(Island.self, from: data) else {
            return nil
        }
        return island
    }
    
    func getLeaderboard() -> Leaderboard? {
        return self.leaderboard
    }
    
    func getSortedUserList(for island: Island) -> [User] {
        return island.userList.sorted(by: { $0.score > $1.score })
    }
    
    func getTopThreeUsers(for islandName: String) -> [User] {
        switch islandName {
        case "Sumatera" :
//            ModelData.shared.sortSumateraRank()
            return Array(ModelData.shared.sumatera.userList.prefix(3))
        case "Sulawesi" :
//            ModelData.shared.sortSulawesiRank()
            return Array(ModelData.shared.sulawesi.userList.prefix(3))
        case "Kalimantan" :
//            ModelData.shared.sortKalimantanRank()
            return Array(ModelData.shared.kalimantan.userList.prefix(3))
        case "Papua" :
//            ModelData.shared.sortPapuaRank()
            return Array(ModelData.shared.papua.userList.prefix(3))
        case "Bali" :
//            ModelData.shared.sortBaliRank()
            return Array(ModelData.shared.bali.userList.prefix(3))
        case "Java" :
//            ModelData.shared.sortJavaRank()
            return Array(ModelData.shared.java.userList.prefix(3))
        default :
            return Array(ModelData.shared.java.userList.prefix(3))
        }
    }
    
    func rearrangeIsland() {
        sortBaliRank()
        sortJavaRank()
        sortKalimantanRank()
        sortSumateraRank()
        sortPapuaRank()
        sortSulawesiRank()
    }
    
    func sortBaliRank() {
        ModelData.shared.bali.userList.sort { $0.score > $1.score }
    }
    
    func sortJavaRank() {
        ModelData.shared.java.userList.sort { $0.score > $1.score }
    }
    
    func sortSumateraRank() {
        ModelData.shared.sumatera.userList.sort { $0.score > $1.score }
    }
    
    func sortKalimantanRank() {
        ModelData.shared.kalimantan.userList.sort { $0.score > $1.score }
    }
    
    func sortPapuaRank() {
        ModelData.shared.papua.userList.sort { $0.score > $1.score }
    }
    
    func sortSulawesiRank() {
        ModelData.shared.sulawesi.userList.sort { $0.score > $1.score }
    }

    func getIsland(islandName: String) -> Island {
        switch islandName {
        case "Sumatera": 
            print("A")
            return ModelData.shared.sumatera
        case "Kalimantan":
            print("B")
            return ModelData.shared.kalimantan
        case "Papua":
            print("C")
            return ModelData.shared.papua
            
        case "Java":
            print("D")
            return ModelData.shared.java
            
        case "Bali":
            print("E")
            return ModelData.shared.bali
            
        case "Sulawesi":
            print("F")
            return ModelData.shared.sulawesi
            
        default:
            print("G")
            return ModelData.shared.bali
            
        }
    }
        
}
