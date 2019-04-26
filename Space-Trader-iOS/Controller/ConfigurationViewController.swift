//
//  ConfigurationViewController.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 2/16/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController, UIPickerViewDelegate {

    var player: Player?
    let MAX_POINTS: Double = 16
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var pilot: UILabel!
    @IBOutlet weak var pilotStep: UIStepper!
    @IBOutlet weak var fighter: UILabel!
    @IBOutlet weak var fighterStep: UIStepper!
    @IBOutlet weak var trader: UILabel!
    @IBOutlet weak var traderStep: UIStepper!
    @IBOutlet weak var engineer: UILabel!
    @IBOutlet weak var engineerStep: UIStepper!
    @IBOutlet weak var difficulty: DifficultyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pilot.text = "0"
        fighter.text = "0"
        trader.text = "0"
        engineer.text = "0"
        
        pilot.textAlignment = .center
        fighter.textAlignment = .center
        trader.textAlignment = .center
        engineer.textAlignment = .center
        
        pilotStep.maximumValue = MAX_POINTS
        fighterStep.maximumValue = MAX_POINTS
        traderStep.maximumValue = MAX_POINTS
        engineerStep.maximumValue = MAX_POINTS
        
        difficulty.delegate = self
        difficulty.dataSource = difficulty
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.object(forKey: "player") != nil {
            let next = (self.storyboard?.instantiateViewController(withIdentifier: "NavigationVC"))!
            self.present(next, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let dest = segue.destination as! UINavigationController
        let target = dest.topViewController as! GameViewController
        // Pass the selected object to the new view controller.
        target.player = self.player
    }

    
    func createPlayer(name: String, difficulty: Difficulty, pilot: Int, fighter: Int, trader: Int, engineer: Int) -> Bool {
        
        if pilot + fighter + trader + engineer == 16 && name != "" {
            self.player = Player(name: name, difficulty: difficulty, pilot: pilot, trader: trader, fighter: fighter, engineer: engineer)
            return true
        } else {
            return false
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficulty.difficulties[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        difficulty.selected = difficulty.difficulties[row]
    }
    
    @IBAction func changePilot(_ sender: Any) {
        pilot.text = Int((sender as! UIStepper).value).description
    }
    
    @IBAction func changeFighter(_ sender: Any) {
        fighter.text = Int((sender as! UIStepper).value).description
    }
    
    @IBAction func changeTrader(_ sender: Any) {
        trader.text = Int((sender as! UIStepper).value).description
    }
    
    @IBAction func changeEngineer(_ sender: Any) {
        engineer.text = Int((sender as! UIStepper).value).description
    }
    
    @IBAction func createPlayer(_ sender: Any) {
        if let name = nameField.text, let pilotVal = Int(pilot.text!), let fighterVal = Int(fighter.text!), let traderVal = Int(trader.text!), let engineerVal = Int(engineer.text!) {
            if createPlayer(name: name, difficulty: difficulty.selected!, pilot: pilotVal, fighter: fighterVal, trader: traderVal, engineer: engineerVal) {
                self.performSegue(withIdentifier: "createPlayer", sender: self)
            } else {
                let alert = UIAlertController(title: "Invalid Input", message: "Please type in a name and make sure your points add up to 16", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
                
        }
    }
}
