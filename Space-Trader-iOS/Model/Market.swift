//
//  Market.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 4/3/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import Foundation
class Market {
    
    lazy var goods: Dictionary = TradeGoodFactory.getGoods()
    
    static func calculatePrice(planet: Planet, good: Tradegood) -> Int {
        
        return 0
    }
    
    
}
