//
//  Ship.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 3/4/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import Foundation
class Ship {
    
    let space: Int = 15
    var spaceRemaining: Int {
        get {
            let space = self.space - self.inventory.map { $0.value.amount }.reduce(0, +)
            return space > 0 ? space : 0
        }
    }
    
    let MAX_FUEL = 1000
    var fuelCapacity = 1000 {
        didSet {
            fuelCapacity = fuelCapacity > MAX_FUEL ? MAX_FUEL : fuelCapacity
        }
    }
    let distCap: Double = pow(10, 3)
    
    lazy var inventory: Dictionary<String, Tradegood> = TradeGoodFactory.getGoods()
}
