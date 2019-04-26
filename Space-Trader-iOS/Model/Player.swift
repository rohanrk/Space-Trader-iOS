//
//  Player.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 2/16/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import Foundation
class Player: Codable {
    
    var name: String
    var ship: Ship = Ship()
    var difficulty: Difficulty
    var credits: Int = 1000
    var pilot: Int
    var trader: Int
    var fighter: Int
    var engineer: Int
    
    var system: SolarSystem?
    var location: Planet?
    
    init(name: String, difficulty: Difficulty, pilot: Int,
         trader: Int, fighter: Int, engineer: Int) {
        self.name = name
        self.difficulty = difficulty
        self.pilot = pilot
        self.trader = trader
        self.fighter = fighter
        self.engineer = engineer
    }
}

enum Difficulty: String, CaseIterable, Codable {
    
    case easy = "Easy", medium = "Medium", hard = "Hard"
}
