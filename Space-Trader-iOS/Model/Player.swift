//
//  Player.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 2/16/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import Foundation
struct Player {
    
    var name: String
    var ship: String = "Gnat"
    var difficulty: Difficulty
    var credits: Int = 1000
    var pilot: Int
    var trader: Int
    var fighter: Int
    var engineer: Int
    
    init(name: String, difficulty: Difficulty, pilot: Int,
         trader: Int, fighter: Int, engineer: Int) {
        self.name = name
        self.difficulty = difficulty
        self.pilot = pilot
        self.trader = trader
        self.fighter = fighter
        self.engineer = engineer
    }
    
    init() {
        self.init(name: "", difficulty: .easy, pilot: 0, trader: 0, fighter: 0, engineer: 0)
    }
}

enum Difficulty: String, EnumCollection {
    
    case easy = "Easy", medium = "Medium", hard = "Hard"
}


// MARK: Enum conforms to CaseIterable when updated to Swift 4.2. 
public protocol EnumCollection: Hashable {
    static func cases() -> AnySequence<Self>
    static var allValues: [Self] { get }
}

public extension EnumCollection {
    
    public static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    public static var allValues: [Self] {
        return Array(self.cases())
    }
}
