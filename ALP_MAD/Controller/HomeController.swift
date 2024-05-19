//
//  HomeController.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation
import UIKit

class HomeController : ObservableObject {
    
    //    @Published private var home : Home
    
    init() {
        
    }
    
    func navigateToLeaderboardView() {
        
    }
    
    func navigateToIslandView() {
        
    }
    
    //    func getHome() -> Home {
    //        return self.home
    //    }
    
    func registerAccount(user: User) {
        ModelData.shared.currentUser = user
    }
}
