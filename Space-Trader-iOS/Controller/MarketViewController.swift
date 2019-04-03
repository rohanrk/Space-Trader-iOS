//
//  MarketViewController.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 3/29/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import UIKit

class MarketViewController: UITabBarController {

    var player: Player?
    // var market: Market?
    // let techLevel = player.location.TL
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = false
        let buy = self.viewControllers?[0] as! BuyViewController
        
        let sell = self.viewControllers?[1] as! SellViewController
        
        sell.player = self.player
        buy.player = self.player
        
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
