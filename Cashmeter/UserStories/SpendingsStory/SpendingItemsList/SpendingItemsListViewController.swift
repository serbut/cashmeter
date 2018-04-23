//
//  SpendingItemsListViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 23/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class SpendingItemsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var spendingItems: [SpendingItemInfo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

// MARK: UITableViewDataSource

extension SpendingItemsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spendingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: SpendingItemTableViewCell.self, at: indexPath) as! SpendingItemTableViewCell
        let itemForCell = spendingItems[indexPath.row]
        
        cell.nameLabel.text = itemForCell.name
        cell.priceCountLabel.text = "\(itemForCell.price) * \(itemForCell.quantity)"
        cell.sumLabel.text = "\(itemForCell.sum)"
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension SpendingItemsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
