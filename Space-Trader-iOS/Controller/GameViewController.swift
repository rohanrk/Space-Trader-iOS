//
//  GameViewController.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 3/4/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var player: Player?
    let universe = Universe.shared()
    
    @IBOutlet weak var planetLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        player?.location = player?.system?.planets.randomElement()
        planetLabel.text = player?.location?.name ?? "Initial"
        planetLabel.textColor = .white
        planetLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle).withSize(36)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
