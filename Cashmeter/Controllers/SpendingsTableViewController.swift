//
//  SpendingsTableViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 23/01/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class SpendingsTableViewController: UITableViewController {

    var spendings = [SpendingItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let foodCategory = SpendingCategory(label: "🍔", title: "Food")
        
        spendings = [
            SpendingItem(category: foodCategory, amount: 100.0, description: nil),
            SpendingItem(category: foodCategory, amount: 180.0, description: nil),
            SpendingItem(category: foodCategory, amount: 320.0, description: nil)
        ]
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spendings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingCell", for: indexPath) as! SpendingTableViewCell
        let spendingForCell = spendings[indexPath.row]
        
        cell.categoryIconLabel.text = spendingForCell.category.label
        cell.categoryNameLabel.text = spendingForCell.category.title
        cell.amountLabel.text = "\(spendingForCell.amount) ₽"
        
        return cell
    }
}
