//
//  LeaderboardController.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation

class LeaderboardController : ObservableObject {
    
    @Published private var leaderboard : Leaderboard
    @Published private var user : User
    @Published private var userList : [User]
    
    init(leaderboard: Leaderboard, user: User, userList: [User]) {
        self.leaderboard = leaderboard
        self.user = user
        self.userList = userList
    }
    
    func navigateToHomeView() {
        
    }
    
    func getLeaderboard() -> Leaderboard {
        return self.leaderboard
    }
    
    func accumulateJavaRanking() {
        
    }
    
    func accumulateKalimantanRanking() {
        
    }
    
    func accumulateSulawesiRanking() {
        
    }
    
    func accumulatePapuaRanking() {
        
    }
    
    func accumulateSumateraRanking() {
        
    }
    
    func accumulateBaliRanking() {
        
    }
    
}
