//
//  TravelViewController.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 3/29/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import UIKit

class TravelViewController: UIViewController, UIPickerViewDelegate {
    

    var player: Player?
    var systems: Set<SolarSystem>?
    
    var system: SolarSystem?
    var selectedPlanet: Planet?
    var fuelCost: Int?
    
    @IBOutlet weak var fuel: UILabel!
    @IBOutlet weak var systemButton: UIButton!
    @IBOutlet weak var planetButton: UIButton!
    
    @IBOutlet var travelView: TravelView!
    @IBOutlet var planetView: PlanetView!
    @IBOutlet weak var travelPicker: UIPickerView!
    @IBOutlet weak var planetPicker: UIPickerView!
    
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    
    var originalEffect: UIVisualEffect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        originalEffect = self.blurEffect.effect
        self.blurEffect.effect = nil
        self.blurEffect.alpha = 0
        self.system = player?.system
        self.selectedPlanet = player?.location
        self.fuel.numberOfLines = 2
        fuelCost = calculateFuelCost(src: player!.system!, dest: self.system!)
        self.systemButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.planetButton.titleLabel?.adjustsFontSizeToFitWidth = true
        configureText()
        
        // Set up subviews
        self.travelView.systems = Array(systems ?? [])
        self.travelView.selected = self.system
        self.planetView.selectedPlanet = self.selectedPlanet
        self.planetView.planets = Array(self.system?.planets ?? [])
        self.travelView.layer.cornerRadius = 10
        self.planetView.layer.cornerRadius = 10
        
        // Set up Pickers
        self.travelPicker.dataSource = self.travelView
        self.travelPicker.delegate = self.travelView
        self.planetPicker.dataSource = self.planetView
        self.planetPicker.delegate = self.planetView
        self.travelPicker.selectRow(travelView.systems?.firstIndex(of: self.system!) ?? 0, inComponent: 0, animated: false)
        self.planetPicker.selectRow(planetView.planets?.firstIndex(of: self.selectedPlanet!) ?? 0, inComponent: 0, animated: false)
    }
    
    func configureText() {
        self.fuel.text = "Fuel Cost\n\(fuelCost ?? 0)"
        self.systemButton.setTitle(self.system?.name, for: .normal)
        self.planetButton.setTitle(self.selectedPlanet?.name, for: .normal)
    }
    
    func shake(view: UIView) {
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = 3
        animation.duration = 0.07
        animation.autoreverses = true
        animation.byValue = 7
        view.layer.add(animation, forKey: "position")
    }
    
    func animateIn(view: UIView) {
        self.view.addSubview(view)
        view.center = self.view.center
        
        view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        view.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.blurEffect.effect = self.originalEffect
            self.blurEffect.alpha = 1
            view.alpha = 1
            view.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut(view: UIView) {
        
        UIView.animate(withDuration: 0.4, animations: {
            
            view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            view.alpha = 0
            self.blurEffect.effect = nil
            self.blurEffect.alpha = 0
        }, completion: { _ in
            view.removeFromSuperview()
        })
    }
    
    func updateFuel(amount: Int) {
        self.player?.ship.fuelCapacity -= amount
    }
    
    func calculateFuelCost(src: SolarSystem, dest: SolarSystem) -> Int {
        let dist = SolarSystem.getDistance(first: src, second: dest)
        let factor = dist / self.player!.ship.distCap
        
        return Int(factor * Double(self.player!.ship.MAX_FUEL))
    }
    
    
    @IBAction func addTravelView(_ sender: Any) {
        self.animateIn(view: travelView)
        
    }
    
    @IBAction func addPlanetView(_ sender: Any) {
        self.animateIn(view: planetView)
    }
    
    @IBAction func selectSystem(_ sender: Any) {
        
        // Fuel logic
        self.system = travelView.selected
        let planets = Array(self.system!.planets)
        self.planetView.planets = planets
        self.planetPicker.reloadAllComponents()
        self.planetPicker.selectRow(0, inComponent: 0, animated: false)
        self.selectedPlanet = planetView.planets?[0]
        fuelCost = self.calculateFuelCost(src: player!.system!, dest: self.system!)
        self.configureText()
        self.animateOut(view: self.travelView)
        
    }
    
    @IBAction func selectPlanet(_ sender: Any) {
        self.selectedPlanet = planetView.selectedPlanet
        self.configureText()
        self.animateOut(view: self.planetView)
    }
    
    @IBAction func travel(_ sender: Any) {
        
        player?.system = self.system ?? player?.system
        player?.location = self.selectedPlanet ?? player?.location
        
        if fuelCost! <= player!.ship.fuelCapacity {
            updateFuel(amount: self.fuelCost!)
            self.navigationController?.popViewController(animated: true)
        } else {
            shake(view: self.view)
        }
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

