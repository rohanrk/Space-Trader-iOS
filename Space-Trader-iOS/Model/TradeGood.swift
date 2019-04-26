//
//  TradeGood.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 4/1/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import Foundation
struct Tradegood: Hashable, Codable {
    
    static let MIN_PRICE = 20
    static let INCREASE_PER_TECH_LEVEL = 10
    
    let type: GoodType
    var price: Int {
        
        didSet {
            price = price > Tradegood.MIN_PRICE ? price : Tradegood.MIN_PRICE
        }
        
    }
    
    let name: String
    var amount: Int // number of resources
    let basePrice: Int
    var variance: Int
    var minTechLevel: Int
    
}

enum GoodType: String, CaseIterable, Codable {
    
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
            var variance = 0
            var minTechLevel = 0
            var basePrice = 0
            switch type {
            case .water:
                variance = 4
                basePrice = 30
            case .furs:
                variance = 10
                basePrice = 250
            case .food:
                variance = 5
                minTechLevel = 1
                basePrice = 100
            case .ore:
                variance = 10
                minTechLevel = 2
                basePrice = 350
            case .medicine:
                variance = 10
                minTechLevel = 4
                basePrice = 650
            case .robots:
                variance = 100
                minTechLevel = 6
                basePrice = 5000
            }
            let good = Tradegood(type: type, price: basePrice, name: type.rawValue, amount: 0, basePrice: basePrice, variance: variance, minTechLevel: minTechLevel)
            goods[type.rawValue] = good
        }
        
        return goods
    }
}
