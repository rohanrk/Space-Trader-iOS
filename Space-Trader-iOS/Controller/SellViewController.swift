//
//  SellViewController.swift
//  Space-Trader-iOS
//
//  Created by Rohan Rk on 4/3/19.
//  Copyright © 2019 Rohan Rk. All rights reserved.
//

import UIKit

class SellViewController: UITableViewController {
    
    var player: Player?
    var market: Market?
    var goods: Dictionary<String, Tradegood>?
    
    @IBOutlet weak var sellGoods: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goods = player?.ship.inventory
        configurePrices()
        self.sellGoods.reloadData()
        //sellGoods.dataSource = self
        //sellGoods.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let parent = self.tabBarController as? MarketViewController
        parent?.player = self.player
        parent?.market = self.market
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return GoodType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sellGood", for: indexPath) as! SellCell
        // Configure the cell
        let name = GoodType.allCases[indexPath.row].rawValue
        cell.textLabel?.text = name
        cell.amount.text = String(goods![name]!.amount)
        cell.price.text = "\(String(goods![name]!.price)) credits"
        cell.selectionStyle = .none
        cell.delegate = self
        
        return cell
    }
    
    private func configurePrices() {
        for (name, good) in market!.goods {
            self.goods![name]?.price = good.price
        }
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

extension SellViewController: MarketCellDelegate {
    
    func handleTransaction(good: String) -> Bool {
        let item = self.market!.goods[good]
        let playerItem = self.player!.ship.inventory[good]
        if playerItem!.amount <= 0 {
            let alert = UIAlertController(title: "Invalid sell", message: "You don't have that item!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        } else {
            self.player?.credits += item!.price
            self.player!.ship.inventory[good]?.amount -= 1
            self.market!.goods[good]?.amount += 1
            return true
        }
    }
    
}
