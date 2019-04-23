//
//  TravelViewController.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 3/29/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import UIKit

class TravelViewController: UIViewController {

    var player: Player?
    var systems: Set<SolarSystem>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
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
