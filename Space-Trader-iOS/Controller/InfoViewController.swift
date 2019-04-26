//
//  InfoViewController.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 4/25/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var player: Player?
    static let moon = 1000000

    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var valueofMoon: UILabel!
    @IBOutlet weak var retire: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var value: Int = player?.ship.inventory.map {
            $0.value.basePrice
            }.reduce(0, +) ?? 0
        
        value += player?.credits ?? 0
        
        totalValue.text = String(value)
        
        valueofMoon.text = String(InfoViewController.moon)
        
        if value >= InfoViewController.moon {
            retire.text = "Good Job! you can retire!"
        } else {
            retire.text = "Still a long way before retirement"
        }
    }
    

    @IBAction func startOver(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you sure?", message: "All your data will be deleted and you will start over in a new universe. Are you certain you want to start over?", preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Yes", style: .destructive) { _ in
            UserDefaults.standard.removeObject(forKey: "player")
            UserDefaults.standard.removeObject(forKey: "universe")
            let config = (self.storyboard?.instantiateInitialViewController())!
            self.present(config, animated: true, completion: nil)
        }
        
        let reject = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alert.addAction(reject)
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
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
