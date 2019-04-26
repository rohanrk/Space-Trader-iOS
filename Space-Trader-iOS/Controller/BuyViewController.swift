//
//  BuyViewController.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 4/3/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import UIKit

class BuyViewController: UITableViewController {
    
    var player: Player?
    var market: Market?
    
    @IBOutlet weak var buyGoods: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buyGoods.dataSource = self
        // buyGoods.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.buyGoods.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GoodType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buyGood", for: indexPath) as! BuyCell
        // Configure the cell...
        let name = GoodType.allCases[indexPath.row].rawValue
        cell.textLabel?.text = name
        cell.amount.text = String(market!.goods[name]!.amount)
        cell.price.text = "\(String(market!.goods[name]!.price)) credits"
        cell.selectionStyle = .none
        cell.delegate = self

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BuyViewController: MarketCellDelegate {
    
    func handleTransaction(good: String) -> Bool {
        let item = self.market!.goods[good]
        if self.player!.credits < item!.price || self.player!.ship.spaceRemaining <= 0 || self.market!.techLevel < item!.minTechLevel || item!.amount <= 0 {
            let alert = UIAlertController(title: "Invalid buy", message: "You cannot buy that item. Do you have enough credits or space? Otherwise, this market might not have the item", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        } else {
            self.player?.credits -= item!.price
            self.player!.ship.inventory[good]?.amount += 1
            self.market!.goods[good]?.amount -= 1
            return true
        }
    }
    
}
