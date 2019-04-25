//
//  TravelView.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 4/24/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import UIKit

class TravelView: UIView, UIPickerViewDataSource {
    
    var systems: [SolarSystem]?
    var selected: SolarSystem?
    
    // MARK: Picker View Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return systems?.count ?? 0
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension TravelView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.systems?[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selected = systems?[row]
    }
    
    

}
