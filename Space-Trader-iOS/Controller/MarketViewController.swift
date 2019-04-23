//
//  MarketViewController.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 3/29/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import UIKit

protocol MarketDataDelegate {
    
    func passData(player: Player, market: Market)
}

class MarketViewController: UITabBarController {

    var player: Player?
    var market: Market?
    var dataProtocol: MarketDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = false
        let buy = self.viewControllers?[0] as! BuyViewController
        
        let sell = self.viewControllers?[1] as! SellViewController
        
        buy.player = self.player
        buy.market = self.market
        
        sell.player = buy.player
        sell.market = buy.market
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dataProtocol?.passData(player: self.player!, market: self.market!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
