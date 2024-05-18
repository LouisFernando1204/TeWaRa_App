//
//  IslandController.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation

class IslandController : ObservableObject {
    
    @Published private var island : Island
    
    init(island: Island) {
        self.island = island
    }
    
    func getIsland() -> Island {
        return self.island
    }
    
    func navigateToPlaySumateraGame() {
        
    }
    
    func navigateToPlayKalimantanGame() {
        
    }
    
    func navigateToPlayPapuaGame() {
        
    }
    
    func navigateToPlaySulawesiGame() {
        
    }
    
    func navigateToPlayBaliGame() {
        
    }
    
    func navigateToPlayJavaGame() {
        
    }
}
