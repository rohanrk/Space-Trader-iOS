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
    private var universe = Universe.shared()
    
    @IBOutlet weak var planetLabel: UILabel!
    @IBOutlet weak var playerData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "player") != nil {
            loadState()
        } else {
            let system = Universe.solarSystems.randomElement()
            player?.system = system
            player?.location = system?.planets.randomElement()
        }
        
        self.navigationController?.delegate = self
        planetLabel.text = player?.location?.name ?? "Initial"
        planetLabel.textColor = .white
        planetLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle).withSize(36)
        playerData.font = UIFont.preferredFont(forTextStyle: .body).withSize(16)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        saveState()
        setDetailLabel()
    }
    
    func setDetailLabel() {
        self.planetLabel.text = player?.location?.name
        self.playerData.numberOfLines = 3
        self.planetLabel.text = player?.location?.name
        self.playerData.text = "Fuel: \(String(player!.ship.fuelCapacity))\nCredits: \(String(player!.credits))\nCargo Space: \(String(player!.ship.spaceRemaining))"
    }
    
    // MARK: - Navigation

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "market" {
            let dest = segue.destination as! MarketViewController
            dest.player = self.player
            dest.market = self.player?.location?.market
        
        } else if segue.identifier == "travel" {
            
            let dest = segue.destination as! TravelViewController
            dest.player = self.player
            dest.systems = Universe.solarSystems
            
        } else if segue.identifier == "info" {
            
        } else {
            
        }
    }
    
    // MARK: - Persistence
    func saveState() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        let player = try? encoder.encode(self.player)
        let universe = try? encoder.encode(self.universe)
        defaults.set(player, forKey: "player")
        defaults.set(universe, forKey: "universe")
    }
    
    func loadState() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        self.player = try? decoder.decode(Player.self, from: (defaults.object(forKey: "player") as? Data)!)
        self.universe = try! decoder.decode(Universe.self, from: (defaults.object(forKey: "universe") as? Data)!)
    }
    
    /*
    override func encodeRestorableState(with coder: NSCoder) {
        <#code#>
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        <#code#>
    } */
}

extension GameViewController: UINavigationControllerDelegate {
    
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.viewWillAppear(animated)
    }
}
