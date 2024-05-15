//
//  TraditionalDanceController.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation
import UIKit

class TraditionalDanceController : ObservableObject {
    
    @Published private var chance : Int
    @Published private var traditionalDance : TraditionalDance
    @Published private var user : User
    
    init(traditionalDance: TraditionalDance, chance: Int, user: User) {
        self.traditionalDance = traditionalDance
        self.chance = chance
        self.user = user
    }
    
    func getUser() -> User {
        return self.user
    }
    
    func wrongAnswer() {
        
    }
    
    func guessWord(word : String) {
        
    }
    
    func correctAnswer() {
        
    }
    
    func accumulatePoint() {
        
    }
    
    func getTraditionalDance() -> TraditionalDance {
        return self.traditionalDance
    }
    
    func getChance() -> Int {
        return self.chance
    }
    
    func navigateToAdditionalQuestionView() {
        
    }
    
}
