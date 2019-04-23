//
//  MarketCell.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 4/20/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import UIKit

protocol MarketCellDelegate {
    
    func handleTransaction(good: String) -> Bool
}

class BuyCell: UITableViewCell {
    
    var delegate: MarketCellDelegate?

    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func buy(_ sender: Any) {
        if delegate!.handleTransaction(good: self.textLabel!.text!) {
            self.amount.text = String(Int(self.amount.text!)! - 1)
        }
    }
    
}

class SellCell: UITableViewCell {
    
    var delegate: MarketCellDelegate?
    
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func sell(_ sender: Any) {
        if delegate!.handleTransaction(good: self.textLabel!.text!) {
            self.amount.text = String(Int(self.amount.text!)! - 1)
        }
    }
}
