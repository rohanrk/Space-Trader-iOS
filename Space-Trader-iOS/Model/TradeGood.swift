//
//  TradeGood.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 4/1/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import Foundation
struct Tradegood: Hashable {
    
    static let MIN_PRICE = 20
    
    let type: GoodType
    var price: Int {
        
        didSet {
            price = price > Tradegood.MIN_PRICE ? price : Tradegood.MIN_PRICE
        }
        
    }
    
    let name: String
    var amount: Int
    var variance: Int
    var minTechLevel: Int
    
}

enum GoodType: String, CaseIterable {
    
    case water = "water"
    case furs = "furs"
    case food = "food"
    case ore = "ore"
    case medicine = "medicine"
    case robots = "robots"
}

class TradeGoodFactory {
    
    static func getGoods() -> Dictionary<String, Tradegood> {
        
        var goods = Dictionary<String, Tradegood>()
        for type in GoodType.allCases {
            goods[type.rawValue] = Tradegood(type: type, price: 0, name: type.rawValue, amount: 0, variance: 0, minTechLevel: 0)
        }
        
        return goods
    }
}
