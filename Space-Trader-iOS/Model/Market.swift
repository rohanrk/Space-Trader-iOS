//
//  Market.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 4/3/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import Foundation
class Market {
    
    static let baseAmount = 20
    static let varianceFactor = 5
    
    var techLevel: Int
    
    init(tech: Int) {
        self.techLevel = tech
        generateGoodData()
    }
    
    lazy var goods: Dictionary = TradeGoodFactory.getGoods()
    
    func generateGoodData() {
        for (name, var good) in goods {
            if good.minTechLevel > techLevel {
                good.amount = 0
            } else {
                good.amount = techLevel > good.minTechLevel ? 5 * Market.baseAmount : Market.baseAmount
            }
            good.price += Tradegood.INCREASE_PER_TECH_LEVEL*(techLevel - good.minTechLevel)
            
            good.price += Int.random(in: 1...10) > 5 ? Market.varianceFactor * good.variance : -1 * Market.varianceFactor * good.variance
            
            goods[name] = good
        }
        
    }
    
    
    
}
